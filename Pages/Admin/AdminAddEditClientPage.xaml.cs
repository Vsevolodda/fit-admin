using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminAddEditClientPage : Page
    {
        private readonly ApplicationDbContext _context;
        private Client? _client;

        public AdminAddEditClientPage(ApplicationDbContext context, Client? client = null)
        {
            InitializeComponent();
            _context = context;
            _client = client;

            if (_client != null)
            {
                TitleTextBlock.Text = "Редактировать клиента";
                FullNameTextBox.Text = _client.FullName;
                DateOfBirthPicker.SelectedDate = _client.DateOfBirth.ToDateTime(new TimeOnly());
                PhoneTextBox.Text = _client.Phone;
                EmailTextBox.Text = _client.Email;
                AddressTextBox.Text = _client.Address;
                MedicalNotesTextBox.Text = _client.MedicalNotes;
                IsActiveCheckBox.IsChecked = _client.IsActive;
            }
            else
            {
                TitleTextBlock.Text = "Добавить клиента";
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(FullNameTextBox.Text) ||
                !DateOfBirthPicker.SelectedDate.HasValue ||
                string.IsNullOrWhiteSpace(PhoneTextBox.Text))
            {
                MessageBox.Show("Заполните все обязательные поля.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (_client == null)
            {
                _client = new Client
                {
                    FullName = FullNameTextBox.Text,
                    DateOfBirth = DateOnly.FromDateTime(DateOfBirthPicker.SelectedDate.Value),
                    Phone = PhoneTextBox.Text,
                    Email = EmailTextBox.Text,
                    Address = AddressTextBox.Text,
                    MedicalNotes = MedicalNotesTextBox.Text,
                    IsActive = IsActiveCheckBox.IsChecked ?? false
                };

                _context.Clients.Add(_client);
            }
            else
            {
                _client.FullName = FullNameTextBox.Text;
                _client.DateOfBirth = DateOnly.FromDateTime(DateOfBirthPicker.SelectedDate.Value);
                _client.Phone = PhoneTextBox.Text;
                _client.Email = EmailTextBox.Text;
                _client.Address = AddressTextBox.Text;
                _client.MedicalNotes = MedicalNotesTextBox.Text;
                _client.IsActive = IsActiveCheckBox.IsChecked ?? false;

                _context.Clients.Update(_client);
            }

            _context.SaveChanges();
            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }

    }
}
