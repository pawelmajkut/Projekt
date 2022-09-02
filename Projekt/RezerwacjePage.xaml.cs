using Projekt.DB;
using Projekt.ViewModels;
using Projekt.Views;
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
using System.Windows.Shapes;

namespace Projekt
{
    /// <summary>
    /// Logika interakcji dla klasy RezerwacjePage.xaml
    /// </summary>
    public partial class RezerwacjePage : Window
    {
        public RezerwacjePage()
        {
            InitializeComponent();
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        List<Produkty> produkties = new List<Produkty>();
        List<Statusy> statusies = new List<Statusy>();
        List<Klienci> kliencis = new List<Klienci>();




        private void btnAnuluj_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        

        private void btnZapisz_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            using (SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext())
            {

            }
            //InitializeComponent();
        }
    }
}
