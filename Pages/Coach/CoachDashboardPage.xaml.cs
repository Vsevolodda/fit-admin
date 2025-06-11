using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Coach
{
    public partial class CoachDashboardPage : Page
    {
        public CoachDashboardPage()
        {
            InitializeComponent();
        }

        private void NavigateButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is string pageName)
            {
                switch (pageName)
                {
                    case "CoachTrainingSchedulePage":
                        DashboardFrame.Navigate(new CoachTrainingSchedulePage());
                        break;
                    case "Exit":
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
