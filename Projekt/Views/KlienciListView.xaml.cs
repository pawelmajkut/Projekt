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
    /// 
    /// </summary>
    public partial class KlienciListView : UserControl
    {
        public KlienciListView()
        {
            InitializeComponent();
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        List<KlienciDetailModel> list2 = new List<KlienciDetailModel>();
        List<Klienci> list = new List<Klienci>();

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            FillDatagrid();

        }

        private void FillDatagrid()
        {

            list2 = db.Kliencis.Select(x => new KlienciDetailModel()
            {
                IdKlienci = x.IdKlienci,
                Imię = x.Imię,
                Nazwisko = x.Nazwisko,
                DataUrodzenia = x.DataUrodzenia,
                AdresZam = x.AdresZam,
                KodPocztowy = x.KodPocztowy,
                Email = x.Email,
                TelKom = x.TelKom,
            }).ToList();

            gridKlienci.ItemsSource = list2;
        }


        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            KlienciPage page = new KlienciPage();
            page.ShowDialog();
            FillDatagrid();
        }

        private void btnZmien_Click(object sender, RoutedEventArgs e)
        {
            
            KlienciDetailModel model = (KlienciDetailModel)gridKlienci.SelectedItem; 
            KlienciPage page = new KlienciPage();
            page.model = model;
            page.ShowDialog();
            FillDatagrid();

        }

        private void btnUsun_Click(object sender, RoutedEventArgs e)
        {
            
            KlienciDetailModel model = (KlienciDetailModel)gridKlienci.SelectedItem;
            Klienci usuwanie = db.Kliencis.Find(model.IdKlienci);
            db.Kliencis.Remove(usuwanie);
           // db.Kliencis.Remove(usuwanie);
            db.SaveChanges();
            MessageBox.Show("Dane klienta zostały usunięte!");
            FillDatagrid();
            
        }

        

        private void btnSzukaj_Click(object sender, RoutedEventArgs e)
        {
            
            string AdresZam = Convert.ToString(txtMiasto.Text);

            var list2 = db.Kliencis.Select(x => new KlienciDetailModel()
            {
                IdKlienci = x.IdKlienci,
                Imię = x.Imię,
                Nazwisko = x.Nazwisko,
                DataUrodzenia = x.DataUrodzenia,
                AdresZam = x.AdresZam,
                KodPocztowy = x.KodPocztowy,
                Email = x.Email,
                TelKom = x.TelKom,
            });

            if (txtImie.Text.Trim() != "")
            {
                list2 = list2.Where(x => EF.Functions.Like(x.Imię, $"{txtImie.Text}%"));
            }
            if (txtNazwisko.Text.Trim() != "")
            {
                list2 = list2.Where(x => EF.Functions.Like(x.Nazwisko, $"{txtNazwisko.Text}%"));
            }
            if (txtMiasto.Text.Trim() != "")
            {
                //list2 = list2.Where(x => x.AdresZam.Contains($"%_{AdresZam}"));
                list2 = list2.Where(x => EF.Functions.Like(x.AdresZam, $"%{AdresZam}%"));
            }
            if (cmbPlec.SelectedIndex != 1 && cmbPlec.SelectedIndex !=-1)
            {
               list2 = list2.Where(x => EF.Functions.Like(x.Imię, $"%[^a]"));
            }
            if (cmbPlec.SelectedIndex != 0 && cmbPlec.SelectedIndex != -1)
            {
               list2 = list2.Where(x => EF.Functions.Like(x.Imię, $"%a"));
            }
            if (Convert.ToInt32(txtWyborRoku.Text) != 0)
            {
                list2 = list2.Where(x => x.DataUrodzenia.Year == Convert.ToInt32(txtWyborRoku.Text));
            }

            gridKlienci.ItemsSource = list2.ToList();  
        }

        
        private void btnWyczysc_Click(object sender, RoutedEventArgs e)
        {
            txtImie.Clear();
            txtNazwisko.Clear();
            txtMiasto.Clear();
            cmbPlec.SelectedIndex = -1;
            txtWyborRoku.Text = Convert.ToString('0');
            FillDatagrid();
        }
    }
}
