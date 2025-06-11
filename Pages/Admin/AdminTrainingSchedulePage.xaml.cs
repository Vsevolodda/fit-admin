using FitAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin;

public partial class AdminTrainingSchedulePage : Page
{
    private ApplicationDbContext _context;

    public AdminTrainingSchedulePage()
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
            .Where(s => !showCompleted ? s.ScheduledDateTime > DateTime.Now : true)
            .Where(s => !s.IsRemoved)
            .OrderBy(s => s.ScheduledDateTime)
            .ToList();

        SchedulesDataGrid.ItemsSource = schedules;
    }

    private void AddSchedule_Click(object sender, RoutedEventArgs e)
    {
        NavigationService?.Navigate(new AdminAddEditTrainingSchedulePage(_context));
    }

    private void EditSchedule_Click(object sender, RoutedEventArgs e)
    {
        if (SchedulesDataGrid.SelectedItem is Schedule selectedSchedule)
        {
            if(selectedSchedule.ScheduledDateTime < DateTime.Now)
            {
                MessageBox.Show("Нельзя редактировать завершённую тренировку. Создайте новую", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            NavigationService?.Navigate(new AdminAddEditTrainingSchedulePage(_context, selectedSchedule));
        }
        else
        {
            MessageBox.Show("Выберите запись для редактирования.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }
    
    private void DeleteSchedule_Click(object sender, RoutedEventArgs e)
    {
        if (SchedulesDataGrid.SelectedItem is Schedule selectedSchedule)
        {
            var result = MessageBox.Show($"Вы уверены, что хотите удалить запись '{selectedSchedule.WorkoutType.Name}'?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                selectedSchedule.IsRemoved = true;
                Booking[] canceledBookings = _context.Bookings.Where(b => b.ScheduleId == selectedSchedule.ScheduleId).ToArray();
                foreach (Booking booking in canceledBookings)
                {
                    booking.IsCancelled = true;
                }

                _context.SaveChanges();
                LoadSchedules(); 
            }
        }
        else
        {
            MessageBox.Show("Выберите запись для удаления.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void DetailsButton_Click(object sender, RoutedEventArgs e)
    {
        if (sender is Button button && button.DataContext is Schedule selectedSchedule)
        {
            var detailsPage = new AdminTrainingDetailsPage(selectedSchedule);
            NavigationService?.Navigate(detailsPage);
        }
    }

    private void SchedulesDataGrid_MouseDoubleClick(object sender, System.Windows.Input.MouseButtonEventArgs e)
    {
        if (SchedulesDataGrid.SelectedItem is Schedule selectedSchedule)
        {
            var detailsPage = new AdminTrainingDetailsPage(selectedSchedule);
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
