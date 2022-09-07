using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Net.Mail;
using Projekt.ViewModels;
using Projekt.DB;
using Microsoft.EntityFrameworkCore;

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy PracownicyListView.xaml
    /// </summary>
    public partial class PracownicyListView : UserControl
    {
        public PracownicyListView()
        {
            InitializeComponent();
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        
        //List<Pracownicy> list = new List<Pracownicy>();

        List<PracownicyViewModel> list2 = new List<PracownicyViewModel>();

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            FillDatagrid();

        }

        private void FillDatagrid()
        {

            var list = db.Producents.Select(a => new {
                ID_producent = a.IdProducent,
                Nazwa = a.Nazwa,
            }).OrderBy(a => a.Nazwa).ToList();

            cmbProducent.ItemsSource = list;
            cmbProducent.DisplayMemberPath = "Nazwa";
            cmbProducent.SelectedValuePath = "IdProducent";
            cmbProducent.SelectedIndex = -1;

            list2 = db.Pracownicies.Select(x => new PracownicyViewModel()
            {
                IdPracownicy = x.IdPracownicy,
                Imię = x.Imię,
                Nazwisko = x.Nazwisko,
                Stanowisko = x.Stanowisko,
                Pesel = x.Pesel,
                //OpiekunProducenta = (int)x.OpiekunProduktu.PracownicyId,
                
            }).ToList();

            //list2 = db.Pracownicies.Include(x => x.OpiekunProduktu).Include(x => x.Producent).Select(x => new PracownicyViewModel()
            //{
            //    IdPracownicy = x.IdPracownicy,
            //    Imię = x.Imię,
            //    Nazwisko = x.Nazwisko,
            //    Stanowisko = x.Stanowisko,
            //    Pesel = x.Pesel,
            //    //OpiekunProducenta = x.Producent.Nazwa,

            //}).ToList();

            gridPracownicy.ItemsSource = list2;
        }

        private void btnSzukaj_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnWyczysc_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnZmien_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnUsun_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
