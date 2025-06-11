using FitAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin;

public partial class AdminCoachesPage : Page
{
    private readonly ApplicationDbContext _context;

    public AdminCoachesPage()
    {
        InitializeComponent();
        _context = new ApplicationDbContext();
        LoadCoaches();
    }

    private void Page_Loaded(object sender, RoutedEventArgs e)
    {
        LoadCoaches();
    }

    private void LoadCoaches()
    {
        var coaches = _context.Users
            .Where(u => u.Role.RoleName == "Тренер" && !u.IsRemoved)
            .ToList();

        CoachesDataGrid.ItemsSource = coaches;
    }

    private void AddCoach_Click(object sender, RoutedEventArgs e)
    {
        NavigationService?.Navigate(new AdminAddEditCoachPage(_context));
    }

    private void EditCoach_Click(object sender, RoutedEventArgs e)
    {
        if (CoachesDataGrid.SelectedItem is User selectedCoach)
        {
            NavigationService?.Navigate(new AdminAddEditCoachPage(_context, selectedCoach));
        }
        else
        {
            MessageBox.Show("Выберите тренера для редактирования.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    // Удаление тренера
    private void DeleteCoach_Click(object sender, RoutedEventArgs e)
    {
        if (CoachesDataGrid.SelectedItem is User selectedCoach)
        {
            var result = MessageBox.Show($"Вы уверены, что хотите удалить тренера {selectedCoach.FullName}?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                selectedCoach.IsRemoved = true;
                _context.SaveChanges();
                LoadCoaches(); 
            }
        }
        else
        {
            MessageBox.Show("Выберите тренера для удаления.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    
}
