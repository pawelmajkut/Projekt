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
using Projekt.ViewModels;
using Projekt.DB;

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy PracownicyPage.xaml
    /// </summary>
    public partial class PracownicyPage : Window
    {
        public bool poprawnosc { get; set; }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        public PracownicyViewModel model;

        public PracownicyPage()
        {
            InitializeComponent();
        }

        private void btnZapisz_Click(object sender, RoutedEventArgs e)
        {

            Pracownicy pracownik = new Pracownicy();
            pracownik.Imię = txtImie.Text;
            pracownik.Nazwisko = txtNazwisko.Text;
            pracownik.Stanowisko = txtStanowisko.Text;
            pracownik.Pesel = txtPesel.Text;
            //pracownik.OpiekunProduktus = Convert.To(cmbProducent.SelectedValue);
            //pracownik.OpiekunProduktus = cmbProducent.Text;
            db.Pracownicies.Add(pracownik);
            db.SaveChanges();
            MessageBox.Show("Pracownik został dodany prawidłowo!");

            txtImie.Clear();
            txtNazwisko.Clear();
            txtStanowisko.Clear();
            txtPesel.Clear();
            cmbProducent.SelectedIndex = -1;

            //poprawnosc = SprawdzPolaFormularza();
            //poprawnosc = SprawdzPoprawnoscDanych(poprawnosc);

            //if (poprawnosc == true && model != null && model.IdPracownicy != 0)
            //{
                
            //    Pracownicy pracownik = db.Pracownicies.Find(model.IdPracownicy);
            //    pracownik.Imię = txtImie.Text;
            //    pracownik.Nazwisko = txtNazwisko.Text;
            //    pracownik.Stanowisko = txtStanowisko.Text;
            //    pracownik.Pesel = txtPesel.Text;
            //    //pracownik.Opie = Convert.ToInt32(cmbProducent.SelectedValue);
                

            //    db.SaveChanges();
            //    MessageBox.Show("Dane klienta zostały zmienione!!");


            //   // OpiekunProduktu opiekun = db.OpiekunProduktus.Find(model.IdPracownicy);

            //}
            //else if (poprawnosc && model == null)
            //{
            //    Pracownicy pracownik = new Pracownicy();
            //    pracownik.Imię = txtImie.Text;
            //    pracownik.Nazwisko = txtNazwisko.Text;
            //    pracownik.Stanowisko = txtStanowisko.Text;
            //    pracownik.Pesel = txtPesel.Text;
            //    //pracownik.OpiekunProduktus = Convert.To(cmbProducent.SelectedValue);
            //    //pracownik.OpiekunProduktus = cmbProducent.Text;
            //    db.Pracownicies.Add(pracownik);
            //    db.SaveChanges();
            //    MessageBox.Show("Pracownik został dodany prawidłowo!");

            //    txtImie.Clear();
            //    txtNazwisko.Clear();
            //    txtStanowisko.Clear();
            //    txtPesel.Clear();
            //    cmbProducent.SelectedIndex = -1;
                
            //}
        }



        private void btnAnuluj_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public bool SprawdzPolaFormularza()
        {

            if (txtImie.Text.Trim() == "" || txtNazwisko.Text.Trim() == ""
                || txtStanowisko.Text.Trim() == "" || txtPesel.Text.Trim() == ""
                )

               // || cmbProducent.SelectedIndex == -1
            {
                MessageBox.Show("Wypełnij wszystkie pola formularza!");
                return false;
            }
            else return true;

        }

        public void btnSprawdz_Click(object sender, RoutedEventArgs e)
        {
            poprawnosc = SprawdzPolaFormularza();

            poprawnosc = SprawdzPoprawnoscDanych(poprawnosc);
            //if (poprawnosc)
            //{
            //    poprawnosc = WalidacjaDataurodzenia((DateTime)picker1.SelectedDate, poprawnosc);
            //    poprawnosc = WalidacjaKodpocztowy(txtKod.Text, poprawnosc);
            //    poprawnosc = WalidacjaEmail(txtEmail.Text, poprawnosc);
            //    poprawnosc = WalidacjaTelefon(txtTel.Text, poprawnosc);

            //    if (poprawnosc) MessageBox.Show("Formularz wypełniony poprawnie!");
            //    else MessageBox.Show("Popraw dane w formularzu!");
            //}
        }

        public bool SprawdzPoprawnoscDanych(bool poprawnosc)
        {
            if (poprawnosc)
            {
                
                poprawnosc = WalidacjaPeselu(txtPesel.Text, poprawnosc);

                if (poprawnosc)
                {
                    MessageBox.Show("Formularz wypełniony poprawnie!");
                    return true;
                }
                else
                {
                    MessageBox.Show("Popraw dane w formularzu!");
                    return false;
                }

            }
            else return false;



        }



        
        public bool WalidacjaPeselu(string pesel, bool poprawnosc)
        {
            if (poprawnosc)
            {
                Regex regexpesel = new Regex("^\\d{11}$");
                bool walidacja = regexpesel.IsMatch(pesel);

                if (walidacja) return true;
                else
                {
                    MessageBox.Show("Wprowadzony niepoprawny PESEL!");
                    txtPesel.Clear();
                    return false;
                }
            }
            else return false;
        }

        
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            cmbProducent.ItemsSource = db.Producents.ToList();
            cmbProducent.DisplayMemberPath = "Nazwa";
            cmbProducent.SelectedValuePath = "IdProducent";
            cmbProducent.SelectedIndex = -1;

            if (model != null && model.IdPracownicy != 0)
            {
                txtImie.Text = model.Imię;
                txtNazwisko.Text = model.Nazwisko;
                txtStanowisko.Text = model.Stanowisko;
                txtPesel.Text = model.Pesel;
                //cmbProducent.SelectedValue = model.Producent;
                
            }

        }
    }
}

