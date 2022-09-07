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

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy KlienciPage.xaml
    /// </summary>
    public partial class KlienciPage : Window
    {
        public bool poprawnosc { get; set; }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        public KlienciDetailModel model;

        
        public KlienciPage()
        {
            InitializeComponent();
        }

        private void btnZapisz_Click(object sender, RoutedEventArgs e)
        {
            poprawnosc = SprawdzFormularz();

            if (model != null && model.IdKlienci != 0)
            {
                Klienci klient = db.Kliencis.Find(model.IdKlienci);
                klient.Imię = txtImie.Text;
                klient.Nazwisko = txtNazwisko.Text;
                klient.DataUrodzenia = (DateTime)picker1.SelectedDate;
                klient.AdresZam = txtAdres.Text;
                klient.KodPocztowy = txtKod.Text;
                klient.Email = txtEmail.Text;
                klient.TelKom = txtTel.Text;

                db.SaveChanges();
                MessageBox.Show("Dane klienta zostały zmienione!!");

                      
            }
            else
            {
                Klienci klient = new Klienci();
                klient.Imię = txtImie.Text;
                klient.Nazwisko = txtNazwisko.Text;
                klient.DataUrodzenia = (DateTime)picker1.SelectedDate;
                klient.AdresZam = txtAdres.Text;
                klient.KodPocztowy = txtKod.Text;
                klient.Email = txtEmail.Text;
                klient.TelKom = txtTel.Text;
                db.Kliencis.Add(klient);
                db.SaveChanges();
                MessageBox.Show("Klient został dodany prawidłowo!");

                txtImie.Clear();
                txtNazwisko.Clear();
                picker1.SelectedDate = null;
                txtAdres.Clear();
                txtKod.Clear();
                txtEmail.Clear();
                txtTel.Clear();


            }
        }



        private void btnAnuluj_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public bool SprawdzFormularz()
        {
            
            if (txtImie.Text.Trim() == "" || txtNazwisko.Text.Trim() == ""
                || txtAdres.Text.Trim() == "" || txtKod.Text.Trim() == ""
                || txtEmail.Text.Trim() == "" || txtTel.Text.Trim() == ""
                || picker1.SelectedDate == null)
            {
                MessageBox.Show("Wypełnij wszystkie pola formularza!");
                return false;
            }
            else return true;
            
        }

        public void btnSprawdz_Click(object sender, RoutedEventArgs e)
        {
            poprawnosc = SprawdzFormularz();

            if (poprawnosc)
            {
                poprawnosc = WalidacjaDataurodzenia((DateTime)picker1.SelectedDate, poprawnosc);
                poprawnosc = WalidacjaKodpocztowy(txtKod.Text, poprawnosc);
                poprawnosc = WalidacjaEmail(txtEmail.Text, poprawnosc);
                poprawnosc = WalidacjaTelefon(txtTel.Text, poprawnosc);
                                          
                if (poprawnosc) MessageBox.Show("Formularz wypełniony poprawnie!");
                else MessageBox.Show("Popraw dane w formularzu!");
            }
        }
                
        public bool WalidacjaDataurodzenia(DateTime urodzenie, bool poprawnosc)
        {
            
            DateTime urodziny = (DateTime)picker1.SelectedDate;

            int wiek = DateTime.Now.Year - urodziny.Year;

            if (DateTime.Now.DayOfYear < urodziny.DayOfYear)
            {
                wiek--;
            }

            if (picker1.SelectedDate <= DateTime.Today & wiek >= 18) return true;
            else
            {
                MessageBox.Show("Klient nie jest pełnoletni!");
                picker1.SelectedDate = null;
                return false;
            }
        }

        public bool WalidacjaTelefon(string telefon, bool poprawnosc)
        {
            if (poprawnosc)
            {
                Regex regexkodpocztowy = new Regex("^\\d{9}$");
                bool walidacja = regexkodpocztowy.IsMatch(telefon);

                if (walidacja) return true;
                else
                {
                    MessageBox.Show("Wprowadzony numer telefonu jest niepoprawny!");
                    txtTel.Clear();
                    return false;
                }
            }
            else return false;         
        }

        public bool WalidacjaEmail(string emailaddress, bool poprawnosc)
        {
            if (poprawnosc)
            {
                try
                {
                    MailAddress m = new MailAddress(emailaddress);
                    return true;
                }
                catch (FormatException)
                {
                    MessageBox.Show("Niepoprawny adres Email!");
                    txtEmail.Clear();
                    return false;
                }
            }
            else return false;         
        }

        public bool WalidacjaKodpocztowy(string kodpocztowy, bool poprawnosc)
        {
            if (poprawnosc)
            {
                Regex regexkodpocztowy = new Regex("^\\d{2}-\\d{3}$");
                bool walidacja = regexkodpocztowy.IsMatch(kodpocztowy);

                if (walidacja) return true;
                else
                {
                    MessageBox.Show("Kod pocztowy niepoprawny !!!");
                    txtKod.Clear();
                    return false;
                }
            }
            else return false;          
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

            if (model != null && model.IdKlienci != 0)
            {
                txtImie.Text = model.Imię;
                txtNazwisko.Text = model.Nazwisko;
                picker1.SelectedDate = model.DataUrodzenia;
                txtAdres.Text = model.AdresZam;
                txtKod.Text = model.KodPocztowy;
                txtEmail.Text = model.Email;
                txtTel.Text = model.TelKom;

            }




        }
    }
}
