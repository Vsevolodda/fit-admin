using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin;

public partial class AdminMembershipsPage : Page
{
    private readonly ApplicationDbContext _context;
    public AdminMembershipsPage()
    {
        InitializeComponent();
        _context = new ApplicationDbContext();
        LoadMembershipTypes();
    }

    private void Page_Loaded(object sender, System.Windows.RoutedEventArgs e)
    {
        LoadMembershipTypes();
    }

    // Загрузка списка типов абонементов
    private void LoadMembershipTypes()
    {
        var membershipTypes = _context.MembershipTypes.Where(m => !m.IsRemoved).ToList();
        MembershipTypesDataGrid.ItemsSource = membershipTypes;
    }

    // Добавление типа абонемента
    private void AddMembershipType_Click(object sender, RoutedEventArgs e)
    {
        NavigationService?.Navigate(new AdminAddEditMembershipTypePage(_context));
    }

    // Редактирование типа абонемента
    private void EditMembershipType_Click(object sender, RoutedEventArgs e)
    {
        if (MembershipTypesDataGrid.SelectedItem is MembershipType selectedMembershipType)
        {
            NavigationService?.Navigate(new AdminAddEditMembershipTypePage(_context, selectedMembershipType));
        }
        else
        {
            MessageBox.Show("Выберите тип абонемента для редактирования.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void DeleteMembershipType_Click(object sender, RoutedEventArgs e)
    {
        if (MembershipTypesDataGrid.SelectedItem is MembershipType selectedMembershipType)
        {
            var result = MessageBox.Show($"Вы уверены, что хотите удалить тип абонемента '{selectedMembershipType.Name}'?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                selectedMembershipType.IsRemoved = true; 
                _context.SaveChanges();
                LoadMembershipTypes(); // Обновляем список после удаления
            }
        }
        else
        {
            MessageBox.Show("Выберите тип абонемента для удаления.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }
}
