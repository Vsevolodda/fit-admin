using FitAdmin.GlobalStorages;
using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages; 

public partial class LoginPage : Page
{
    private readonly ApplicationDbContext _context;

    public LoginPage()
    {
        InitializeComponent();
        _context = new ApplicationDbContext();
    }

    private void LoginButton_Click(object sender, RoutedEventArgs e)
    {
        string username = UsernameTextBox.Text.Trim();
        string password = PasswordBox.Password.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            ErrorMessageTextBlock.Text = "Введите имя пользователя и пароль.";
            return;
        }

        var user = _context.Users.FirstOrDefault(u =>
            u.Login == username && u.PasswordHash == password && u.IsActive && !u.IsRemoved);

        if (user == null)
        {
            ErrorMessageTextBlock.Text = "Неверное имя пользователя или пароль.";
            return;
        }


        GlobalStorage.UserId = user.UserId;
        var role = _context.Roles.FirstOrDefault(r => r.RoleId == user.RoleId)?.RoleName;

        if (role == "Администратор")
        {
            NavigationService?.Navigate(new Admin.AdminDashboardPage());
        }
        else if (role == "Тренер")
        {
            NavigationService?.Navigate(new Coach.CoachDashboardPage());
        }
        else
        {
            ErrorMessageTextBlock.Text = "У вас нет доступа к системе.";
        }
    }
}
