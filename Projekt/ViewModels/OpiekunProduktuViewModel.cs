using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt.ViewModels
{
    public class OpiekunProduktuViewModel
    {

        public int IdOpiekun { get; set; }
        public int PracownicyId { get; set; }
        public int ProducentId { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public string Stanowisko { get; set; }
        public string Pesel { get; set; }
        public string Nazwa { get; set; }

    }
}
