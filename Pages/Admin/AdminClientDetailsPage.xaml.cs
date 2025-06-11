using FitAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminClientDetailsPage : Page
    {
        private readonly ApplicationDbContext _context;
        private readonly Client _client;
        public AdminClientDetailsPage(Client client)
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
            _client = client;

            DataContext = _client;

            LoadBookings();
            LoadMemberships();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadBookings();
            LoadMemberships();
        }

        private void LoadBookings()
        {
            var bookings = _context.Bookings
                .Include(b => b.Schedule)
                .ThenInclude(s => s.WorkoutType)
                .Include(b => b.Schedule.Trainer)
                .Where(b => b.ClientId == _client.ClientId && !b.IsCancelled)
                .OrderBy(b => b.Schedule.ScheduledDateTime)
                .Select(b => new BookingViewModel
                {
                    WorkoutTypeName = b.Schedule.WorkoutType.Name,
                    ScheduledDateTime = b.Schedule.ScheduledDateTime,
                    TrainerName = b.Schedule.Trainer.FullName,
                    Room = b.Schedule.Room,
                    Schedule = b.Schedule
                })
                .ToList();

            BookingsDataGrid.ItemsSource = bookings;
        }

        private void LoadMemberships()
        {
            var memberships = _context.Memberships
                .Include(m => m.MembershipType)
                .Where(m => m.ClientId == _client.ClientId)
                .OrderByDescending(m => m.EndDate)
                .Select(m => new MembershipViewModel
                {
                    MembershipId = m.MembershipId,
                    MembershipTypeName = m.MembershipType.Name,
                    Duration = $"C {m.StartDate} по {m.EndDate}",
                    Price = m.MembershipType.Price,
                    Restrictions = m.MembershipType.Restrictions ?? "Нет ограничений",
                    IsActive = m.EndDate >= DateOnly.FromDateTime(DateTime.Now)
                })
                .ToList();

            MembershipsDataGrid.ItemsSource = memberships;
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }

        private void BookingsDataGrid_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (BookingsDataGrid.SelectedItem is BookingViewModel selectedBooking)
            {
                var detailsPage = new AdminTrainingDetailsPage(selectedBooking.Schedule);
                NavigationService?.Navigate(detailsPage);
            }
        }

        private void SaleMemberships_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new AdminSaleMembershipsPage(_client.ClientId));
        }

        private void CancelMembership_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is int membershipId)
            {
                var membership = _context.Memberships.FirstOrDefault(m => m.MembershipId == membershipId);
                if (membership != null)
                {
                    _context.Memberships.Remove(membership);
                    _context.SaveChanges();

                    LoadMemberships(); // Обновляем список абонементов
                    MessageBox.Show("Абонемент успешно отменен.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
        }
    }

    public class BookingViewModel
    {
        public string WorkoutTypeName { get; set; }
        public DateTime ScheduledDateTime { get; set; }
        public string TrainerName { get; set; }
        public string Room { get; set; }
        public Schedule Schedule { get; set; }
    }

    public class MembershipViewModel
    {
        public int MembershipId { get; set; }
        public string MembershipTypeName { get; set; }
        public string Duration { get; set; }
        public decimal Price { get; set; }
        public string Restrictions { get; set; }
        public Membership Membership { get; set; }
        public bool IsActive { get; set; }
    }
}
