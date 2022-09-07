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

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy KlienciPage.xaml
    /// </summary>
    public partial class KlienciPage : Window
    {
        public bool poprawność { get; set; }
        
        public KlienciPage()
        {
            InitializeComponent();
        }

        private void btnZapisz_Click(object sender, RoutedEventArgs e)
        {

        }



        private void btnAnuluj_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public bool SprawdźFormularz()
        {
            
            if (txtImię.Text.Trim() == "" || txtNazwisko.Text.Trim() == ""
                || txtAdres.Text.Trim() == "" || txtKod.Text.Trim() == ""
                || txtEmail.Text.Trim() == "" || txtTel.Text.Trim() == ""
                || picker1.SelectedDate == null)
            {
                MessageBox.Show("Wypełnij wszystkie pola formularza!");
                return false;
            }
            else return true;
            
        }

        public void btnSprawdź_Click(object sender, RoutedEventArgs e)
        {
            poprawność = SprawdźFormularz();

            if (poprawność)
            {
                
                poprawność = WalidacjaDataurodzenia((DateTime)picker1.SelectedDate, poprawność);
                poprawność = WalidacjaKodpocztowy(txtKod.Text, poprawność);
                poprawność = WalidacjaEmail(txtEmail.Text, poprawność);
                poprawność = WalidacjaTelefon(txtTel.Text, poprawność);
                               
                
                if (poprawność) MessageBox.Show("Formularz wypełniony poprawnie!");
                else MessageBox.Show("Popraw dane w formularzu!");

            }
            

        }
                
        public bool WalidacjaDataurodzenia(DateTime urodzenie, bool poprawność)
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

        public bool WalidacjaTelefon(string telefon, bool poprawność)
        {
            if (poprawność)
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

        public bool WalidacjaEmail(string emailaddress, bool poprawność)
        {
            if (poprawność)
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

        public bool WalidacjaKodpocztowy(string kodpocztowy, bool poprawność)
        {
            if (poprawność)
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
    }
}
