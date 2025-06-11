using FitAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin;

public partial class AdminClientsPage : Page
{
    private readonly ApplicationDbContext _context;
    public AdminClientsPage()
    {
        InitializeComponent();
        _context = new ApplicationDbContext();
        LoadClients();
    }

    private void Page_Loaded(object sender, RoutedEventArgs e)
    {
        LoadClients();
    }

    private void LoadClients()
    {
        string searchText = SearchTextBox.Text.Trim();
        var query = _context.Clients
            .Include(c => c.Memberships)
            .ThenInclude(m => m.MembershipType)
            .Where(c => c.IsActive == !ShowInActiveCheckBox.IsChecked || c.IsActive)
            .Where(c => !c.IsRemoved)
            .OrderBy(c => c.FullName)
            .AsQueryable();

        var clients = query.ToList();

        if (!string.IsNullOrWhiteSpace(searchText))
        {
            clients = clients
                .Where(c =>
                    c.FullName.Contains(searchText, StringComparison.OrdinalIgnoreCase) ||
                    c.Phone.Contains(searchText) ||
                    (c.Email != null && c.Email.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                    c.ClientId.ToString() == searchText)
                .ToList();
        }

        ClientsDataGrid.ItemsSource = clients;
    }

    private void SearchButton_Click(object sender, RoutedEventArgs e)
    {
        LoadClients();
    }

    private void AddClient_Click(object sender, RoutedEventArgs e)
    {
        NavigationService?.Navigate(new AdminAddEditClientPage(_context));
    }

    private void EditClient_Click(object sender, RoutedEventArgs e)
    {
        if (ClientsDataGrid.SelectedItem is Client selectedClient)
        {
            NavigationService?.Navigate(new AdminAddEditClientPage(_context, selectedClient));
        }
        else
        {
            MessageBox.Show("Выберите клиента для редактирования.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void DeleteClient_Click(object sender, RoutedEventArgs e)
    {
        if (ClientsDataGrid.SelectedItem is Client selectedClient)
        {
            var result = MessageBox.Show($"Вы уверены, что хотите удалить клиента {selectedClient.FullName}?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                selectedClient.IsRemoved = true;    
                _context.SaveChanges();
                LoadClients();
            }
        }
        else
        {
            MessageBox.Show("Выберите клиента для удаления.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void ShowInActiveCheckBox_Checked(object sender, RoutedEventArgs e)
    {
        LoadClients();
    }

    private void ShowInActiveCheckBox_Unchecked(object sender, RoutedEventArgs e)
    {
        LoadClients();
    }

    private void ClientsDataGrid_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
    {
        if (ClientsDataGrid.SelectedItem is Client selectedClient)
        {
            var detailsPage = new AdminClientDetailsPage(selectedClient);
            NavigationService?.Navigate(detailsPage);
        }
    }
}
