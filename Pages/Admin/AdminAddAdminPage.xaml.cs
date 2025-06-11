using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminAddAdminPage : Page
    {
        private readonly ApplicationDbContext _context;

        public AdminAddAdminPage()
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(LoginTextBox.Text) ||
                string.IsNullOrWhiteSpace(EmailTextBox.Text) ||
                string.IsNullOrWhiteSpace(FullNameTextBox.Text) ||
                string.IsNullOrWhiteSpace(PasswordBox.Password))
            {
                MessageBox.Show("Заполните все поля.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            var role = _context.Roles.FirstOrDefault(r => r.RoleName == "Администратор");
            if (role == null)
            {
                MessageBox.Show("Роль 'Admin' не найдена.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            
            var existingUserWithLogin = _context.Users.FirstOrDefault(u => u.Login == LoginTextBox.Text && !u.IsRemoved);
            if (existingUserWithLogin != null)
            {
                MessageBox.Show("Пользователь с таким логином уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            var admin = new User
            {
                Login = LoginTextBox.Text,
                Email = EmailTextBox.Text,
                FullName = FullNameTextBox.Text,
                PasswordHash = PasswordBox.Password, // В реальности используйте хэширование
                RoleId = role.RoleId,
                IsActive = IsActiveCheckBox.IsChecked ?? false
            };

            _context.Users.Add(admin);
            _context.SaveChanges();

            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }
    }
}
