using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminAddEditTrainingTypePage : Page
    {
        private readonly ApplicationDbContext _context;
        private WorkoutType? _workoutType;

        public AdminAddEditTrainingTypePage(ApplicationDbContext context, WorkoutType? workoutType = null)
        {
            InitializeComponent();
            _context = context;
            _workoutType = workoutType;

            if (_workoutType != null)
            {
                TitleTextBlock.Text = "Редактировать тип тренировки";
                NameTextBox.Text = _workoutType.Name;
            }
            else
            {
                TitleTextBlock.Text = "Добавить тип тренировки";
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(NameTextBox.Text))
            {
                MessageBox.Show("Заполните название типа тренировки.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (_workoutType == null)
            {
                _workoutType = new WorkoutType
                {
                    Name = NameTextBox.Text
                };

                _context.WorkoutTypes.Add(_workoutType);
            }
            else
            {
                _workoutType.Name = NameTextBox.Text;
                _context.WorkoutTypes.Update(_workoutType);
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
