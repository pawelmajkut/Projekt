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

namespace Projekt.Views
{
    /// <summary>
    /// Logika interakcji dla klasy KlienciListView.xaml
    /// </summary>
    public partial class KlienciListView : UserControl
    {
        public KlienciListView()
        {
            InitializeComponent();
        }

        SklepInternetowy_BAJTContext db = new SklepInternetowy_BAJTContext();
        List<KlienciViewModel> list = new List<KlienciViewModel>();

        private void WybórRoku_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {

        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnZmień_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnUsuń_Click(object sender, RoutedEventArgs e)
        {

        }

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnClear_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
