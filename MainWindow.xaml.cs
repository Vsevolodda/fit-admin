using FitAdmin.Pages;
using System.Windows;

namespace FitAdmin; 

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
        MainFrame.Navigate(new LoginPage());
    }
}