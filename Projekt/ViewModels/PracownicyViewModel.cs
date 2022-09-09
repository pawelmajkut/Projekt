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
       // public int OpiekunProducenta { get; set; } // 00:38 09.09.2022
        public string Producent { get; set; }  /// TUTAJ - ostatnio aktywowanie godzina 23:24
    }
}
