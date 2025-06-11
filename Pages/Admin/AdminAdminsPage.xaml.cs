using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin;

public partial class AdminAdminsPage : Page
{
    private readonly ApplicationDbContext _context;
    public AdminAdminsPage()
    {
        InitializeComponent();
        _context = new ApplicationDbContext();
        LoadAdmins();
    }

    private void Page_Loaded(object sender, RoutedEventArgs e)
    {
        LoadAdmins();
    }

    private void LoadAdmins()
    {
        var admins = _context.Users
            .Where(u => u.Role.RoleName == "Администратор" && !u.IsRemoved)
            .ToList();

        AdminsDataGrid.ItemsSource = admins;
    }

    private void AddAdmin_Click(object sender, RoutedEventArgs e)
    {
        NavigationService?.Navigate(new AdminAddAdminPage());
    }

    private void EditAdmin_Click(object sender, RoutedEventArgs e)
    {
        if (AdminsDataGrid.SelectedItem is User selectedAdmin)
        {
            NavigationService?.Navigate(new AdminEditAdminPage(selectedAdmin));
        }
        else
        {
            MessageBox.Show("Выберите администратора для редактирования.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void DeleteAdmin_Click(object sender, System.Windows.RoutedEventArgs e)
    {
        if (AdminsDataGrid.SelectedItem is User selectedAdmin)
        {
            var result = MessageBox.Show($"Вы уверены, что хотите удалить администратора {selectedAdmin.FullName}?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                selectedAdmin.IsRemoved = true; 
                _context.SaveChanges();
                LoadAdmins(); 
            }
        }
        else
        {
            MessageBox.Show("Выберите администратора для удаления.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }
}
