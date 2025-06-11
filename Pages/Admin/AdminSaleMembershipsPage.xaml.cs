using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin;

public partial class AdminSaleMembershipsPage : Page
{
    private readonly ApplicationDbContext _context;

    public AdminSaleMembershipsPage(int? clientId = null)
    {
        InitializeComponent();
        _context = new ApplicationDbContext();

        LoadClients(clientId);
        LoadMembershipTypes();
    }

    private void LoadClients(int? clientId)
    {
        var clients = _context.Clients.Where(c => c.IsActive && !c.IsRemoved).ToList();
        ClientComboBox.ItemsSource = clients;
        if (clientId != null)
        {
            var client = clients.First(c => c.ClientId == clientId);
            ClientComboBox.SelectedItem = client;

            var lastMembership = _context.Memberships
                .Where(m => m.ClientId == client.ClientId)
                .OrderByDescending(m => m.EndDate)
                .FirstOrDefault();

            LastMembershipEndDateTextBlock.Text = lastMembership != null
                ? $"Окончание: {lastMembership.EndDate.ToDateTime(TimeOnly.MinValue):dd.MM.yyyy}"
                : "Нет активных абонементов";
        }
        else
        {
            LastMembershipEndDateTextBlock.Text = "Выберите клиента";
        }
    }

    private void LoadMembershipTypes()
    {
        var membershipTypes = _context.MembershipTypes.Where(m => !m.IsRemoved).ToList();
        MembershipTypeComboBox.ItemsSource = membershipTypes;

        MembershipTypeComboBox.SelectionChanged += MembershipTypeComboBox_SelectionChanged;
    }

    private void MembershipTypeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (MembershipTypeComboBox.SelectedItem is MembershipType selectedMembershipType &&
            StartDatePicker.SelectedDate.HasValue)
        {
            var startDate = StartDatePicker.SelectedDate.Value;
            var endDate = startDate.AddDays(selectedMembershipType.DurationDays);
            EndDateTextBlock.Text = endDate.ToString("dd.MM.yyyy");
        }
    }

    private void StartDatePicker_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
    {
        if (MembershipTypeComboBox.SelectedItem is MembershipType selectedMembershipType &&
            StartDatePicker.SelectedDate.HasValue)
        {
            var startDate = StartDatePicker.SelectedDate.Value;
            var endDate = startDate.AddDays(selectedMembershipType.DurationDays);
            EndDateTextBlock.Text = endDate.ToString("dd.MM.yyyy");
        }
    }

    private void SellMembership_Click(object sender, RoutedEventArgs e)
    {
        if (ClientComboBox.SelectedItem is Client selectedClient &&
            MembershipTypeComboBox.SelectedItem is MembershipType selectedMembershipType &&
            StartDatePicker.SelectedDate.HasValue)
        {
            var startDate = StartDatePicker.SelectedDate.Value;

            var lastMembership = _context.Memberships
           .Where(m => m.ClientId == selectedClient.ClientId)
           .OrderByDescending(m => m.EndDate)
           .FirstOrDefault();

            if (lastMembership != null && startDate < lastMembership.EndDate.ToDateTime(TimeOnly.MinValue))
            {
                MessageBox.Show("Дата начала нового абонемента не может быть раньше даты окончания предыдущего.",
                                "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var endDate = startDate.AddDays(selectedMembershipType.DurationDays);

            var newMembership = new Membership
            {
                ClientId = selectedClient.ClientId,
                MembershipTypeId = selectedMembershipType.MembershipTypeId,
                StartDate = DateOnly.FromDateTime(startDate),
                EndDate = DateOnly.FromDateTime(endDate),
                CreatedAt = DateTime.Now
            };

            _context.Memberships.Add(newMembership);
            _context.SaveChanges();

            MessageBox.Show("Абонемент успешно продан.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);

            ClientComboBox.SelectedItem = null;
            MembershipTypeComboBox.SelectedItem = null;
            StartDatePicker.SelectedDate = null;
            EndDateTextBlock.Text = string.Empty;
        }
        else
        {
            MessageBox.Show("Пожалуйста, заполните все поля.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void ClientComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (ClientComboBox.SelectedItem is Client selectedClient)
        {
            var lastMembership = _context.Memberships
                .Where(m => m.ClientId == selectedClient.ClientId)
                .OrderByDescending(m => m.EndDate)
                .FirstOrDefault();

            LastMembershipEndDateTextBlock.Text = lastMembership != null
                ? $"Окончание: {lastMembership.EndDate.ToDateTime(TimeOnly.MinValue):dd.MM.yyyy}"
                : "Нет активных абонементов";
        }
    }
}
