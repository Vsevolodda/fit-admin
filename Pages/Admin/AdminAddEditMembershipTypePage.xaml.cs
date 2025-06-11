using FitAdmin.Models;
using System.Windows;
using System.Windows.Controls;

namespace FitAdmin.Pages.Admin
{
    public partial class AdminAddEditMembershipTypePage : Page
    {
        private readonly ApplicationDbContext _context;
        private MembershipType? _membershipType;

        public AdminAddEditMembershipTypePage(ApplicationDbContext context, MembershipType? membershipType = null)
        {
            InitializeComponent();
            _context = context;
            _membershipType = membershipType;

            if (_membershipType != null)
            {
                TitleTextBlock.Text = "Редактировать тип абонемента";
                NameTextBox.Text = _membershipType.Name;
                PriceTextBox.Text = _membershipType.Price.ToString();
                DurationDaysTextBox.Text = _membershipType.DurationDays.ToString();
                RestrictionsTextBox.Text = _membershipType.Restrictions;
            }
            else
            {
                TitleTextBlock.Text = "Добавить тип абонемента";
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(NameTextBox.Text) ||
                !decimal.TryParse(PriceTextBox.Text, out var price) ||
                !int.TryParse(DurationDaysTextBox.Text, out var durationDays))
            {
                MessageBox.Show("Заполните все поля корректно.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (_membershipType == null)
            {
                _membershipType = new MembershipType
                {
                    Name = NameTextBox.Text,
                    Price = price,
                    DurationDays = durationDays,
                    Restrictions = RestrictionsTextBox.Text
                };

                _context.MembershipTypes.Add(_membershipType);
            }
            else
            {
                _membershipType.Name = NameTextBox.Text;
                _membershipType.Price = price;
                _membershipType.DurationDays = durationDays;
                _membershipType.Restrictions = RestrictionsTextBox.Text;

                _context.MembershipTypes.Update(_membershipType);
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
