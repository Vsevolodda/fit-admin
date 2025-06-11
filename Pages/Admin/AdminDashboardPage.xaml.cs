using FitAdmin.GlobalStorages;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminDashboardPage : Page
    {
        public AdminDashboardPage()
        {
            InitializeComponent();
        }

        private void NavigateButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is string pageName)
            {
                switch (pageName)
                {
                    case "AdminsPage":
                        DashboardFrame.Navigate(new AdminAdminsPage());
                        break;
                    case "AdminCoachesPage":
                        DashboardFrame.Navigate(new AdminCoachesPage());
                        break;
                    case "AdminClientsPage":
                        DashboardFrame.Navigate(new AdminClientsPage());
                        break;
                    case "AdminTrainingsPage":
                        DashboardFrame.Navigate(new AdminTrainingsPage());
                        break;
                    case "AdminTrainingSchedulePage":
                        DashboardFrame.Navigate(new AdminTrainingSchedulePage());
                        break;
                    case "AdminMembershipsPage":
                        DashboardFrame.Navigate(new AdminMembershipsPage());
                        break;
                    case "AdminSaleMembershipsPage":
                        DashboardFrame.Navigate(new AdminSaleMembershipsPage());
                        break;
                    case "Exit":
                        GlobalStorage.UserId = null; 
                        NavigationService.Navigate(new LoginPage());
                        break;

                    default:
                        MessageBox.Show("Страница не найдена.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                        break;
                }
            }
        }
    }
}
