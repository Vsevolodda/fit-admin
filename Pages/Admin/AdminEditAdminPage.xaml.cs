using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminEditAdminPage : Page
    {
        private readonly ApplicationDbContext _context;
        private readonly User _admin;

        public AdminEditAdminPage(User admin)
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
            _admin = admin;

            // Заполняем поля данными администратора
            LoginTextBox.Text = _admin.Login;
            EmailTextBox.Text = _admin.Email;
            FullNameTextBox.Text = _admin.FullName;
            IsActiveCheckBox.IsChecked = _admin.IsActive;
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(LoginTextBox.Text) ||
                string.IsNullOrWhiteSpace(EmailTextBox.Text) ||
                string.IsNullOrWhiteSpace(FullNameTextBox.Text))
            {
                MessageBox.Show("Заполните все поля.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            _admin.Login = LoginTextBox.Text;
            _admin.Email = EmailTextBox.Text;
            _admin.FullName = FullNameTextBox.Text;
            _admin.PasswordHash = PasswordBox.Password; // В реальности обновляйте только при необходимости
            _admin.IsActive = IsActiveCheckBox.IsChecked ?? false;

            _context.Users.Update(_admin);
            _context.SaveChanges();

            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }
    }
}
