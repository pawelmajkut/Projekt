using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt.ViewModels
{
    public class PracownicyViewModel
    {
        public int IdPracownicy { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public string Stanowisko { get; set; }
        public string Pesel { get; set; }
        public int OpiekunProducenta { get; set; }
       // public string Producent { get; set; }
    }
}
