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
            //var list = db.Kliencis.ToList().OrderBy(x => x.Imię);
            //cmbImięNazwisko.ItemsSource = list;
            //cmbImięNazwisko.DisplayMemberPath = "Nazwisko" ;
            //cmbImięNazwisko.SelectedValuePath = "IdKlienci";
            //cmbImięNazwisko.SelectedIndex = -1;

            var list = db.Kliencis.Select(a => new {
                ID_klienci = a.IdKlienci,
                Imię=a.Imię,
                ImięNazwisko=a.Imię + " " + a.Nazwisko,
                Nazwisko=a.Nazwisko,
            }).OrderBy(a=> a.Nazwisko).ToList();

            cmbImięNazwisko.ItemsSource = list;
            cmbImięNazwisko.DisplayMemberPath = "ImięNazwisko";
            cmbImięNazwisko.SelectedValuePath = "IdKlienci";
            cmbImięNazwisko.SelectedIndex = -1;

            var produkty = db.Produkties.Select(a => new
            {
                ID_produkty=a.IdProdukty,
                Nazwa=a.Nazwa,
            }).OrderBy(a => a.ID_produkty).ToList();

            cmbProdukt.ItemsSource = produkty;
            cmbProdukt.DisplayMemberPath = "Nazwa";
            cmbProdukt.SelectedValuePath = "ID_Produkty";
            cmbProdukt.SelectedIndex = -1;

            var statusy = db.Statusies.Select(a => new {
                ID_statusy=a.IdStatusy,
                Nazwa=a.Nazwa,
            }).OrderBy(a => a.Nazwa).ToList();

            cmbStatus.ItemsSource = statusy;
            cmbStatus.DisplayMemberPath = "Nazwa";
            cmbStatus.SelectedValuePath = "ID_statusy";
            cmbStatus.SelectedIndex = -1;


        }
    }
}
