using Projekt.DB;
using Projekt.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Projekt
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            using (SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext())
            {

            }

        }

        private void btnRezerwacje_Click(object sender, RoutedEventArgs e)
        {
            lblWindowName.Content = "Rezerwacje";
            DataContext = new RezerwacjeViewModel();
            
        }

        private void btnKlienci_Click(object sender, RoutedEventArgs e)
        {
            lblWindowName.Content = "Klienci";
            DataContext = new KlienciViewModel();
           
        }

        private void btnProdukty_Click(object sender, RoutedEventArgs e)
        {
            lblWindowName.Content = "Produkty";
            
        }

        private void btnKoszyki_Click(object sender, RoutedEventArgs e)
        {
            lblWindowName.Content = "Rezerwacje";

        }

        private void btnPracownicy_Click(object sender, RoutedEventArgs e)
        {
            lblWindowName.Content = "Pracownicy";

        }

        private void btnZakończ_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
