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
        public KlienciPage()
        {
            InitializeComponent();
        }

        private void btnZapisz_Click(object sender, RoutedEventArgs e)
        {

        }



        private void btnAnuluj_Click(object sender, RoutedEventArgs e)
        {

        }



        private void btnSprawdź_Click(object sender, RoutedEventArgs e)
        {
            //Regex regexkodpocztowy = new Regex("^\\d{2}-\\d{3}$");
            //bool walidacja = regexkodpocztowy.IsMatch(txtKod.Text);
            //if (walidacja == true)
            //{
            //    MessageBox.Show("Kod pocztowy poprawny");
            //}
            //if (walidacja == false)
            //{
            //    MessageBox.Show("Kod pocztowy niepoprawny !!!");
            //    txtKod.Clear();

            //}
            WalidacjaKodpocztowy(txtKod.Text);
            WalidacjaEmail(txtEmail.Text);

            //Regex regexmail = new Regex(/^[a-z\d]+[\w\d.-]*@(?:[a-z\d]+[a-z\d-]+\.){1,5}[a-z]{2,6}$/i);
            //bool walidacja2 = regexmail.IsMatch(txtEmail.Text);

            //if (walidacja2 == false)
            //{
            //    MessageBox.Show("Niepoprawny adres Email!");
            //    txtEmail.Clear();
            //}

        }

        //private void WalidacjaEmail()
        //{
        //    Regex regexmail = new Regex("^[\\d]{8}\\|[a-zA-Z]+\\|[a-zA-Z]+\\|([\\w]+[-_]?[\\w]*)+@[\\w]+.[\\w]+\\|$");
        //    bool walidacja = regexmail.IsMatch(txtKod.Text);

        //    if (walidacja == false)
        //    {
        //        MessageBox.Show("Niepoprawny adres Email!");
        //        txtEmail.Clear();
        //    }
        //}


        private void WalidacjaEmail(string emailaddress)
        {
            try
            {
                MailAddress m = new MailAddress(emailaddress);

                MessageBox.Show("POPRAWNY adres Email!");
            }
            catch (FormatException)
            {
                MessageBox.Show("Niepoprawny adres Email!");
                txtEmail.Clear();
            }


        }

        private void WalidacjaKodpocztowy(string kodpocztowy)
        {
            Regex regexkodpocztowy = new Regex("^\\d{2}-\\d{3}$");
            bool walidacja = regexkodpocztowy.IsMatch(kodpocztowy);

            if (walidacja == true)
            {
                MessageBox.Show("Kod pocztowy poprawny");
            }
            if (walidacja == false)
            {
                MessageBox.Show("Kod pocztowy niepoprawny !!!");
                txtKod.Clear();

            }
        }
    }
}
