using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminTrainingsPage : Page
    {
        private readonly ApplicationDbContext _context;

        public AdminTrainingsPage()
        {
            InitializeComponent();
            _context = new ApplicationDbContext();
            LoadWorkoutTypes();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadWorkoutTypes();
        }

        private void LoadWorkoutTypes()
        {
            var workoutTypes = _context.WorkoutTypes.Where(w => !w.IsRemoved).ToList();
            WorkoutTypesDataGrid.ItemsSource = workoutTypes;
        }

        // Добавление типа тренировки
        private void AddTrainingType_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new AdminAddEditTrainingTypePage(_context));
        }

        // Редактирование типа тренировки
        private void EditTrainingType_Click(object sender, RoutedEventArgs e)
        {
            if (WorkoutTypesDataGrid.SelectedItem is WorkoutType selectedWorkoutType)
            {
                NavigationService?.Navigate(new AdminAddEditTrainingTypePage(_context, selectedWorkoutType));
            }
            else
            {
                MessageBox.Show("Выберите тип тренировки для редактирования.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        // Удаление типа тренировки
        private void DeleteTrainingType_Click(object sender, RoutedEventArgs e)
        {
            if (WorkoutTypesDataGrid.SelectedItem is WorkoutType selectedWorkoutType)
            {
                var result = MessageBox.Show($"Вы уверены, что хотите удалить тип тренировки '{selectedWorkoutType.Name}'?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    selectedWorkoutType.IsRemoved = true;   
                    _context.SaveChanges();
                    LoadWorkoutTypes(); 
                }
            }
            else
            {
                MessageBox.Show("Выберите тип тренировки для удаления.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
    }
}
