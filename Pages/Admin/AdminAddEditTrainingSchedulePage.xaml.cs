using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminAddEditTrainingSchedulePage : Page
    {
        private readonly ApplicationDbContext _context;
        private Schedule? _schedule;

        public AdminAddEditTrainingSchedulePage (ApplicationDbContext context, Schedule? schedule = null)
        {
            InitializeComponent();
            _context = context;
            _schedule = schedule;

            WorkoutTypeComboBox.ItemsSource = _context.WorkoutTypes.Where(w => !w.IsRemoved).ToList();
            TrainerComboBox.ItemsSource = _context.Users.Where(u => u.Role.RoleName == "Тренер" && u.IsActive && !u.IsRemoved).ToList();

            if (_schedule != null)
            {
                TitleTextBlock.Text = "Редактировать запись";
                WorkoutTypeComboBox.SelectedItem = _context.WorkoutTypes.FirstOrDefault(wt => wt.WorkoutTypeId == _schedule.WorkoutTypeId);
                TrainerComboBox.SelectedItem = _context.Users.FirstOrDefault(u => u.UserId == _schedule.TrainerId);
                ScheduledDateTimePicker.SelectedDate = _schedule.ScheduledDateTime.Date;
                TimeTextBox.Text = _schedule.ScheduledDateTime.ToString("HH:mm");
                RoomTextBox.Text = _schedule.Room;
                MaxParticipantsTextBox.Text = _schedule.MaxParticipants.ToString();
            }
            else
            {
                TitleTextBlock.Text = "Добавить запись";
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (WorkoutTypeComboBox.SelectedItem is not WorkoutType selectedWorkoutType ||
                TrainerComboBox.SelectedItem is not User selectedTrainer ||
                !DateTime.TryParse(ScheduledDateTimePicker.SelectedDate?.ToString("yyyy-MM-dd") + " " + TimeTextBox.Text, out var scheduledDateTime) ||
                !int.TryParse(MaxParticipantsTextBox.Text, out var maxParticipants))
            {
                MessageBox.Show("Заполните все поля корректно.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if(scheduledDateTime < DateTime.Now)
            {
                MessageBox.Show("Укажите корректную дату и время начала тренировки", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }


            if (maxParticipants <= 0)
            {
                MessageBox.Show("Укажите корректное максимальное кол-во участников тренировки.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (_schedule == null)
            {
                _schedule = new Schedule
                {
                    WorkoutTypeId = selectedWorkoutType.WorkoutTypeId,
                    TrainerId = selectedTrainer.UserId,
                    ScheduledDateTime = scheduledDateTime,
                    Room = RoomTextBox.Text,
                    MaxParticipants = maxParticipants
                };

                _context.Schedules.Add(_schedule);
            }
            else
            {
                _schedule.WorkoutTypeId = selectedWorkoutType.WorkoutTypeId;
                _schedule.TrainerId = selectedTrainer.UserId;
                _schedule.ScheduledDateTime = scheduledDateTime;
                _schedule.Room = RoomTextBox.Text;
                _schedule.MaxParticipants = maxParticipants;

                _context.Schedules.Update(_schedule);
            }

            _context.SaveChanges();
            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack(); // Возвращаемся на предыдущую страницу
        }

        private void DateOnly_PreviewTextInput(object sender, System.Windows.Input.TextCompositionEventArgs e)
        {
            if (!char.IsDigit(e.Text, 0) && e.Text != ".")
            {
                e.Handled = true;
            }
        }

        private void TimeOnly_PreviewTextInput(object sender, System.Windows.Input.TextCompositionEventArgs e)
        {
            if (!char.IsDigit(e.Text, 0) && e.Text != ":")
            {
                e.Handled = true;
            }
        }

        private void NumberOnly_PreviewTextInput(object sender, System.Windows.Input.TextCompositionEventArgs e)
        {
            // Разрешаем только цифры
            if (!char.IsDigit(e.Text, 0))
            {
                e.Handled = true; // Отменяем ввод, если символ не является цифрой
            }
        }
    }
}
