using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt.ViewModels
{
    public class RezerwacjeDetailModel
    {

        public int IdRezerwacje { get; set; }
        public int KlientId { get; set; }
        public int ProduktId { get; set; }
        public int StatusId { get; set; }
        public DateTime DataKoncaRezerwacji { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public string Nazwa { get; set; }
        public string Status { get; set; }

    }
}
