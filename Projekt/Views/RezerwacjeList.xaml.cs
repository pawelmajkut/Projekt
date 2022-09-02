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
            //using (SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext())
            //{
            //    List<RezerwacjeProduktów> list = db.RezerwacjeProduktóws.ToList(); ; //.OrderBy(x => x.KlientId).ToList();
            //    gridRezerwacje.ItemsSource = list;
            //}
            FillDatagrid();
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        List<RezerwacjeDetailModel> list = new List<RezerwacjeDetailModel>();

        void FillDatagrid()
        {
            list = db.RezerwacjeProduktóws.Include(x => x.Klient).Include(x => x.Produkt).Include(x => x.Status).Select(x => new RezerwacjeDetailModel()
            {
                IdRezerwacje = x.IdRezerwacje,
                KlientId = (int)x.KlientId,
                ProduktId = (int)x.ProduktId,
                StatusId = (int)x.StatusId,
                DataKoncaRezerwacji = (DateTime)x.DataKoncaRezerwacji,
                Imię=x.Klient.Imię,
                Nazwisko=x.Klient.Nazwisko,
                Nazwa=x.Produkt.Nazwa,
                Status=x.Status.Nazwa,

            }).ToList();

            gridRezerwacje.ItemsSource = list;
        }
    }
}
