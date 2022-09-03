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
using Projekt.DB;
using Projekt.ViewModels;
using Projekt.Views;
using Microsoft.EntityFrameworkCore;

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy KlienciListView.xaml
    /// </summary>
    public partial class KlienciListView : UserControl
    {
        public KlienciListView()
        {
            InitializeComponent();
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        //List<KlienciViewModel> list = new List<KlienciViewModel>();
        List<Klienci> list = new List<Klienci>();

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            FillDatagrid();

        }

        void FillDatagrid()
        {
            List<Klienci> list = db.Kliencis.OrderBy(x => x.Nazwisko).ToList();

            gridKlienci.ItemsSource = list;
        }

        private void WybórRoku_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {

        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnZmień_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnUsuń_Click(object sender, RoutedEventArgs e)
        {

        }

        

        private void btnSzukaj_Click(object sender, RoutedEventArgs e)
        {
            string AdresZam = Convert.ToString(txtMiasto.Text);
            List<Klienci> wyszukiwanie = list;
            if (txtMiasto.Text.Trim() != "")
                //wyszukiwanie = wyszukiwanie.Where(x => x.AdresZam == Convert.ToString(txtMiasto.Text)).ToList();
                //string AdresZam = Convert.ToString(txtMiasto.Text);
                //wyszukiwanie = wyszukiwanie.Where(x => x.AdresZam.EndsWith("Kraków")).ToList();
                //wyszukiwanie = wyszukiwanie.Where(x => EF.Functions.Like(x.AdresZam, "%Kraków")).ToList();
                list = db.Kliencis.Where(x => EF.Functions.Like(x.AdresZam, $"%{AdresZam}")).ToList();
            if ()
            gridKlienci.ItemsSource = list;
        }

        private void btnWyczyść_Click(object sender, RoutedEventArgs e)
        {

        }

        private void cmbPłeć_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}
