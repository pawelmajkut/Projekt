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
        //List<Produkty> produkties = new List<Produkty>();
        //List<Statusy> statusies = new List<Statusy>();
        //List<Klienci> kliencis = new List<Klienci>();
        public RezerwacjeDetailModel model;



        private void btnAnuluj_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        

        private void btnZapisz_Click(object sender, RoutedEventArgs e)
        {
            if (cmbImięNazwisko.SelectedIndex == -1 || cmbProdukt.SelectedIndex == -1 || cmbStatus.SelectedIndex == -1)
            {
                MessageBox.Show("Wprowadzono niepoprawne dane!");
            }
            if (picker1.SelectedDate <= DateTime.Today || picker1.SelectedDate == null)
            {
                MessageBox.Show("Wprowadzono niepoprawna datę!");
            }
            else 
            {
                if (model != null && model.IdRezerwacje != 0)
                {
                    RezerwacjeProduktów rezerwacje = db.RezerwacjeProduktóws.Find(model.IdRezerwacje);
                    rezerwacje.KlientId = Convert.ToInt32(cmbImięNazwisko.SelectedValue);
                    rezerwacje.ProduktId = Convert.ToInt32(cmbProdukt.SelectedValue);
                    rezerwacje.StatusId = Convert.ToInt32(cmbStatus.SelectedValue);
                    rezerwacje.DataKoncaRezerwacji = (DateTime)picker1.SelectedDate;

                    db.SaveChanges();
                    MessageBox.Show("Rezerwacja została zmieniona!");

                }
                else
                {
                    RezerwacjeProduktów rezerwacje = new RezerwacjeProduktów();
                    rezerwacje.KlientId = Convert.ToInt32(cmbImięNazwisko.SelectedValue);
                    rezerwacje.ProduktId = Convert.ToInt32(cmbProdukt.SelectedValue);
                    rezerwacje.StatusId = Convert.ToInt32(cmbStatus.SelectedValue);
                    rezerwacje.DataKoncaRezerwacji = (DateTime)picker1.SelectedDate;


                    db.RezerwacjeProduktóws.Add(rezerwacje);
                    db.SaveChanges();
                    MessageBox.Show("Rezerwacja dodana!");

                    cmbImięNazwisko.SelectedIndex = -1;
                    cmbProdukt.SelectedIndex = -1;
                    cmbStatus.SelectedIndex = -1;
                    picker1.SelectedDate = null;
                }

            }




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
            cmbImięNazwisko.SelectedValuePath = "ID_klienci";
            cmbImięNazwisko.SelectedIndex = -1;

            var produkty = db.Produkties.Select(a => new
            {
                ID_produkty=a.IdProdukty,
                Nazwa=a.Nazwa,
            }).OrderBy(a => a.ID_produkty).ToList();

            cmbProdukt.ItemsSource = produkty;
            cmbProdukt.DisplayMemberPath = "Nazwa";
            cmbProdukt.SelectedValuePath = "ID_produkty";
            cmbProdukt.SelectedIndex = -1;

            var statusy = db.Statusies.Select(a => new {
                IdStatusy = a.IdStatusy,
                Nazwa=a.Nazwa,
            }).OrderBy(a => a.Nazwa).ToList();

            cmbStatus.ItemsSource = statusy;
            cmbStatus.DisplayMemberPath = "Nazwa";
            cmbStatus.SelectedValuePath = "IdStatusy";
            cmbStatus.SelectedIndex = -1;

            if (model != null && model.IdRezerwacje != 0)
            {
                cmbImięNazwisko.SelectedValue = model.KlientId;
                cmbProdukt.SelectedValue = model.ProduktId;
                cmbStatus.SelectedValue = model.StatusId;
                picker1.SelectedDate = model.DataKoncaRezerwacji;
            }



        }

        
    }
}
