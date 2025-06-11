using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin; 

public partial class AdminAddEditCoachPage : Page
{
    private readonly ApplicationDbContext _context;
    private User? _coach;

    public AdminAddEditCoachPage(ApplicationDbContext context, User coach = null)
    {
        InitializeComponent();

        _context = context;
        _coach = coach;

        if (_coach != null)
        {
            TitleTextBlock.Text = "Редактировать тренера";
            LoginTextBox.Text = _coach.Login;
            EmailTextBox.Text = _coach.Email;
            FullNameTextBox.Text = _coach.FullName;
            SpecializationTextBox.Text = _coach.Specialization;
            PhoneTextBox.Text = _coach.Phone;
            IsActiveCheckBox.IsChecked = _coach.IsActive;
        }
        else
        {
            TitleTextBlock.Text = "Добавить тренера";
        }
    }

    private void SaveButton_Click(object sender, RoutedEventArgs e)
    {
        if (string.IsNullOrWhiteSpace(LoginTextBox.Text) ||
            string.IsNullOrWhiteSpace(EmailTextBox.Text) ||
            string.IsNullOrWhiteSpace(FullNameTextBox.Text) ||
            (string.IsNullOrWhiteSpace(PasswordBox.Password) && _coach == null))
        {
            MessageBox.Show("Заполните все обязательные поля.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            return;
        }

        int userId = _coach?.UserId ?? 0; 
        var existingUserWithEmail = _context.Users.FirstOrDefault(u => u.Email == EmailTextBox.Text && u.UserId != userId);
        if (existingUserWithEmail != null)
        {
            MessageBox.Show("Пользователь с такой почтой уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            return;
        }

        var existingUserWithLogin= _context.Users.FirstOrDefault(u => u.Login == LoginTextBox.Text && u.UserId != userId && !u.IsRemoved);
        if (existingUserWithLogin != null)
        {
            MessageBox.Show("Пользователь с таким логином уже существует.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            return;
        }

        if (_coach == null)
        {
            var role = _context.Roles.FirstOrDefault(r => r.RoleName == "Тренер");
            if (role == null)
            {
                MessageBox.Show("Роль 'Trainer' не найдена.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            _coach = new User
            {
                Login = LoginTextBox.Text,
                Email = EmailTextBox.Text,
                FullName = FullNameTextBox.Text,
                PasswordHash = PasswordBox.Password, 
                RoleId = role.RoleId,
                Specialization = SpecializationTextBox.Text,
                Phone = PhoneTextBox.Text,
                IsActive = IsActiveCheckBox.IsChecked ?? false
            };

            _context.Users.Add(_coach);
        }
        else
        {
            _coach.Login = LoginTextBox.Text;
            _coach.Email = EmailTextBox.Text;
            _coach.FullName = FullNameTextBox.Text;
            _coach.PasswordHash = (PasswordBox.Password != _coach.PasswordHash && PasswordBox.Password.Trim() != "") ? PasswordBox.Password : _coach.PasswordHash;
            _coach.IsActive = IsActiveCheckBox.IsChecked ?? false;
            _coach.Specialization = SpecializationTextBox.Text;
            _coach.Phone = PhoneTextBox.Text;

            _context.Users.Update(_coach);
        }

        _context.SaveChanges();
        NavigationService?.GoBack();
    }

    private void CancelButton_Click(object sender, RoutedEventArgs e)
    {
        NavigationService?.GoBack(); 
    }
}
