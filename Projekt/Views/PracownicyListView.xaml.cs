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

        List<OpiekunProduktuViewModel> list = new List<OpiekunProduktuViewModel>();

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            FillDatagrid();

        }

        private void FillDatagrid()
        {
            var list2 = db.Producents.Select(a => new
            {
                ID_producent = a.IdProducent,
                Nazwa = a.Nazwa,
            }).OrderBy(a => a.Nazwa).ToList();

            cmbProducent.ItemsSource = list2;
            cmbProducent.DisplayMemberPath = "Nazwa";
            cmbProducent.SelectedValuePath = "IdProducent";
            cmbProducent.SelectedIndex = -1;

           list = db.OpiekunProduktus.Include(x => x.Pracownicy).Include(x => x.Producent).Select(x => new OpiekunProduktuViewModel()
            {
               IdOpiekun =x.IdOpiekun,
               PracownicyId = (int)x.PracownicyId,
               ProducentId =(int)x.ProducentId,
               Imię=x.Pracownicy.Imię,
               Nazwisko=x.Pracownicy.Nazwisko,
               Stanowisko=x.Pracownicy.Stanowisko,
               Pesel=x.Pracownicy.Pesel,
               Nazwa=x.Producent.Nazwa,                
            }).ToList();


            // DZIAŁA WYPEŁNIANIE GRIDA - nie działa pokazywanie kolumny OpiekunowieProducenta //
            //var list = db.Producents.Select(a => new {
            //    ID_producent = a.IdProducent,
            //    Nazwa = a.Nazwa,
            //}).OrderBy(a => a.Nazwa).ToList();

            //cmbProducent.ItemsSource = list;
            //cmbProducent.DisplayMemberPath = "Nazwa";
            //cmbProducent.SelectedValuePath = "IdProducent";
            //cmbProducent.SelectedIndex = -1;

            //list2 = db.Pracownicies.Select(x => new PracownicyViewModel()
            //{
            //    IdPracownicy = x.IdPracownicy,
            //    Imię = x.Imię,
            //    Nazwisko = x.Nazwisko,
            //    Stanowisko = x.Stanowisko,
            //    Pesel = x.Pesel,
            //    //OpiekunProducenta = (int)x.OpiekunProduktu.PracownicyId,

            //}).ToList();

            //list2 = db.Pracownicies.Include(x => x.OpiekunProduktu).Include(x => x.Producent).Select(x => new PracownicyViewModel()
            //{
            //    IdPracownicy = x.IdPracownicy,
            //    Imię = x.Imię,
            //    Nazwisko = x.Nazwisko,
            //    Stanowisko = x.Stanowisko,
            //    Pesel = x.Pesel,
            //    //OpiekunProducenta = x.Producent.Nazwa,

            //}).ToList();

            gridPracownicy.ItemsSource = list;
        }

        private void btnSzukaj_Click(object sender, RoutedEventArgs e)
        {
            var list = db.OpiekunProduktus.Include(x => x.Pracownicy).Include(x => x.Producent).Select(x => new OpiekunProduktuViewModel()
            {
                IdOpiekun = x.IdOpiekun,
                PracownicyId = (int)x.PracownicyId,
                ProducentId = (int)x.ProducentId,
                Imię = x.Pracownicy.Imię,
                Nazwisko = x.Pracownicy.Nazwisko,
                Stanowisko = x.Pracownicy.Stanowisko,
                Pesel = x.Pracownicy.Pesel,
                Nazwa = x.Producent.Nazwa,
            });


            if (txtImie.Text.Trim() != "")
            {
                list = list.Where(x => EF.Functions.Like(x.Imię, $"{txtImie.Text}%"));
            }
            if (txtNazwisko.Text.Trim() != "")
            {
                list = list.Where(x => EF.Functions.Like(x.Nazwisko, $"{txtNazwisko.Text}%"));
            }
            if (txtStanowisko.Text.Trim() != "")
            {
                string stanowisko = Convert.ToString(txtStanowisko.Text);
                list = list.Where(x => EF.Functions.Like(x.Stanowisko, $"%{stanowisko}%"));
               // list = list.Where(x => x.Stanowisko.Contains($"{stanowisko}"));
            }
            if (cmbPlec.SelectedIndex != 1 && cmbPlec.SelectedIndex != -1)
            {
                list = list.Where(x => EF.Functions.Like(x.Imię, $"%[^a]"));
            }
            if (cmbPlec.SelectedIndex != 0 && cmbPlec.SelectedIndex != -1)
            {
               list = list.Where(x => EF.Functions.Like(x.Imię, $"%a"));

            }
            if (cmbProducent.SelectedIndex != -1)
            {
                list = list.Where(x => EF.Functions.Like(x.Nazwa, $"{cmbProducent.Text}"));
            }

            // int producent = Convert.ToInt32(cmbProducent.SelectedValue);

            // list = list.Where(x => x.Nazwa == cmbProducent.SelectedValue);
            //if (Convert.ToInt32(txtWyborRoku.Text) != 1925)
            //{
            //    list2 = list2.Where(x => x.DataUrodzenia.Year == Convert.ToInt32(txtWyborRoku.Text));
            //}

            gridPracownicy.ItemsSource = list.ToList();
        }

        private void btnWyczysc_Click(object sender, RoutedEventArgs e)
        {
            txtImie.Clear();
            txtNazwisko.Clear();
            cmbPlec.SelectedIndex = -1;
            txtStanowisko.Clear();
            cmbProducent.SelectedIndex = -1;

            gridPracownicy.ItemsSource = list;

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
