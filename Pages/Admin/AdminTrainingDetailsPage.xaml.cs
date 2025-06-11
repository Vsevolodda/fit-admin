using FitAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminTrainingDetailsPage : Page
    {
        private readonly ApplicationDbContext _context;
        private readonly Schedule _schedule;
        private List<Client> _allClients;
        private int _bookedClientsCount;

        public AdminTrainingDetailsPage(Schedule schedule)
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
            _schedule = schedule;

            DataContext = _schedule;

            LoadBookedClients();
            LoadAllClients();
        }

        private void LoadBookedClients()
        {
            var bookedClients = _context.Bookings
                .Include(b => b.Client)
                .Where(b => b.ScheduleId == _schedule.ScheduleId && !b.IsCancelled)
                .ToList();

            BookedClientsListBox.ItemsSource = bookedClients;
            _bookedClientsCount = bookedClients.Count();
        }

        private void LoadAllClients()
        {
            _allClients = _context.Clients.Where(c => c.IsActive).ToList();
            ClientsDataGrid.ItemsSource = _allClients;
        }

        private void BookClientButton_Click(object sender, RoutedEventArgs e)
        {
            if (ClientsDataGrid.SelectedItem is Client selectedClient)
            {
                var isAlreadyBooked = _context.Bookings
                    .FirstOrDefault(b => b.ScheduleId == _schedule.ScheduleId && b.ClientId == selectedClient.ClientId);

                if (isAlreadyBooked != null && !isAlreadyBooked.IsCancelled)
                {
                    MessageBox.Show("Этот клиент уже записан на тренировку.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                if(_bookedClientsCount >= _schedule.MaxParticipants)
                {
                    MessageBox.Show("Записано максимальное количество клиентов.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                if (isAlreadyBooked != null && isAlreadyBooked.IsCancelled)
                {
                    isAlreadyBooked.IsCancelled = false;
                }
                else
                {
                    var booking = new Booking
                    {
                        ScheduleId = _schedule.ScheduleId,
                        ClientId = selectedClient.ClientId,
                        BookingDateTime = DateTime.Now
                    };

                    _context.Bookings.Add(booking);

                }
                
                _context.SaveChanges();

                LoadBookedClients(); 
                MessageBox.Show("Клиент успешно записан на тренировку.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else
            {
                MessageBox.Show("Выберите клиента для записи.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void CancelBookingButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.DataContext is Booking selectedBooking)
            {
                selectedBooking.IsCancelled = true;
                _context.Bookings.Update(selectedBooking);
                _context.SaveChanges();

                LoadBookedClients();
                LoadAllClients();
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }

        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var searchText = SearchTextBox.Text.Trim().ToLower();

            var filteredClients = string.IsNullOrEmpty(searchText)
                ? _allClients
                : _allClients.Where(c =>
                    c.FullName.ToLower().Contains(searchText) ||
                    c.Phone.Contains(searchText) ||
                    c.ClientId.ToString().Contains(searchText))
                  .ToList();

            ClientsDataGrid.ItemsSource = filteredClients;
        }
    }
}
