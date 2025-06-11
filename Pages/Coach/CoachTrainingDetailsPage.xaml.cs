using FitAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Coach
{
    public partial class CoachTrainingDetailsPage : Page
    {
        private readonly ApplicationDbContext _context;
        private readonly Schedule _schedule;

        public CoachTrainingDetailsPage(Schedule schedule)
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
            _schedule = schedule;

            DataContext = _schedule;

            LoadBookedClients();
        }

        private void LoadBookedClients()
        {
            var bookedClients = _context.Bookings
                .Include(b => b.Client)
                .Where(b => b.ScheduleId == _schedule.ScheduleId && !b.IsCancelled)
                .ToList();

            BookedClientsListBox.ItemsSource = bookedClients;
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }
    }
}
