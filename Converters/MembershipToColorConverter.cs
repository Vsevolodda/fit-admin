using System.Globalization;
using System.Windows.Data;
using System.Windows.Media;

namespace FitAdmin.Converters
{
    public class MembershipToColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            // Проверяем, есть ли активный абонемент
            if (value is string membership && membership.Contains("Нет активного абонемента"))
            {
                return Brushes.Red; // Красный цвет, если абонемента нет
            }

            return Brushes.Black; // Черный цвет по умолчанию
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
