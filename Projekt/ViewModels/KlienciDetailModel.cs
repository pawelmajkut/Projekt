using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt.ViewModels
{
   public class KlienciDetailModel
    {

        public int IdKlienci { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public DateTime DataUrodzenia { get; set; }
        public string AdresZam { get; set; }
        public string KodPocztowy { get; set; }
        public string Email { get; set; }
        public string TelKom { get; set; }

    }
}
