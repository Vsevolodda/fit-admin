using FitAdmin.GlobalStorages;
using FitAdmin.Models;
using FitAdmin.Pages.Admin;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Coach
{
    public partial class CoachTrainingSchedulePage : Page
    {
        private ApplicationDbContext _context;

        public CoachTrainingSchedulePage()
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
            LoadSchedules();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadSchedules();
        }

        private void LoadSchedules()
        {
            _context = new ApplicationDbContext();

            bool showCompleted = ShowCompletedCheckBox.IsChecked ?? false;

            var schedules = _context.Schedules
                .Include(s => s.Trainer)
                .Include(s => s.Bookings)
                .Include(s => s.WorkoutType)
                .Where(s => s.Trainer.UserId == GlobalStorage.UserId)
                .Where(s => !showCompleted ? s.ScheduledDateTime > DateTime.Now : true)
                .ToList();

            SchedulesDataGrid.ItemsSource = schedules;
        }

        private void DetailsButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.DataContext is Schedule selectedSchedule)
            {
                var detailsPage = new CoachTrainingDetailsPage(selectedSchedule);
                NavigationService?.Navigate(detailsPage);
            }
        }

        private void SchedulesDataGrid_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (SchedulesDataGrid.SelectedItem is Schedule selectedSchedule)
            {
                var detailsPage = new CoachTrainingDetailsPage(selectedSchedule);
                NavigationService?.Navigate(detailsPage);
            }
        }

        private void ApplyDateFilter_Click(object sender, RoutedEventArgs e)
        {
            if (DateFilterPicker.SelectedDate.HasValue)
            {
                var selectedDate = DateFilterPicker.SelectedDate.Value.Date;

                var filteredSchedules = _context.Schedules
                    .Include(s => s.Trainer)
                    .Include(s => s.WorkoutType)
                    .Where(s => s.ScheduledDateTime.Date == selectedDate)
                    .ToList();

                SchedulesDataGrid.ItemsSource = filteredSchedules;
            }
            else
            {
                MessageBox.Show("Выберите дату для фильтрации.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void ResetDateFilter_Click(object sender, RoutedEventArgs e)
        {
            LoadSchedules();
            DateFilterPicker.SelectedDate = null;
        }

        private void ShowCompletedCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            LoadSchedules();
        }

        private void ShowCompletedCheckBox_Unchecked(object sender, RoutedEventArgs e)
        {
            LoadSchedules();
        }
    }
}
