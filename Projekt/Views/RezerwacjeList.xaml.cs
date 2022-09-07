using Microsoft.EntityFrameworkCore;
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

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy RezerwacjeList.xaml
    /// </summary>
    public partial class RezerwacjeList : UserControl
    {
        public RezerwacjeList()
        {
            InitializeComponent();
                       
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        List<RezerwacjeDetailModel> list = new List<RezerwacjeDetailModel>();

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            FillDatagrid();

        }

        void FillDatagrid()
        {
            list = db.RezerwacjeProduktóws.Include(x => x.Klient).Include(x => x.Produkt).Include(x => x.Status).Select(x => new RezerwacjeDetailModel()
            {
                IdRezerwacje = x.IdRezerwacje,
                KlientId = (int)x.KlientId,
                ProduktId = (int)x.ProduktId,
                StatusId = (int)x.StatusId,
                DataKoncaRezerwacji = x.DataKoncaRezerwacji,
                Imię= x.Klient.Imię,
                Nazwisko= x.Klient.Nazwisko,
                Nazwa= x.Produkt.Nazwa,
                Status= x.Status.Nazwa,

            }).ToList();

            gridRezerwacje.ItemsSource = list;
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            RezerwacjePage page = new RezerwacjePage();
            page.ShowDialog();
            FillDatagrid();
        }

        private void btnUsun_Click(object sender, RoutedEventArgs e)
        {
            RezerwacjeDetailModel model = (RezerwacjeDetailModel)gridRezerwacje.SelectedItem;
            RezerwacjeProduktów rez = db.RezerwacjeProduktóws.Find(model.IdRezerwacje);
            db.RezerwacjeProduktóws.Remove(rez);
            db.SaveChanges();
            MessageBox.Show("Rezerwacja została usunięta!");
            FillDatagrid();
        }

        private void btnZmien_Click(object sender, RoutedEventArgs e)
        {
            RezerwacjeDetailModel model = (RezerwacjeDetailModel)gridRezerwacje.SelectedItem;
            RezerwacjePage page = new RezerwacjePage();
            page.model = model;
            page.ShowDialog();
            FillDatagrid();
        }
    }
}
