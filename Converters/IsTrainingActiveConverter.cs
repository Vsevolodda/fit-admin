using System.Globalization;
using System.Windows.Data;

namespace FitAdmin.Converters
{
    public class IsTrainingActiveConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is DateTime scheduledDateTime)
            {
                return scheduledDateTime > DateTime.Now; // Разрешено, если тренировка еще не началась
            }

            return false; // По умолчанию запрещено
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
