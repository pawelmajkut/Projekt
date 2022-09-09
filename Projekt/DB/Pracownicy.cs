using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Pracownicy
    {
        public Pracownicy()
        {
            OpiekunProduktus = new HashSet<OpiekunProduktu>(); 
            Producents = new HashSet<Producent>();  // 00:32 09.09.2022 swieze
        }

        public int IdPracownicy { get; set; } 
        public string Imię { get; set; } 
        public string Nazwisko { get; set; }
        public string Stanowisko { get; set; }
        public string Pesel { get; set; }

        //public string OpiekunProducenta { get; set; }

       // public virtual OpiekunProduktu OpiekunProduktu { get; set; } // TUTAJ NOC
        //public virtual Producent Producent { get; set; } 

        public virtual ICollection<OpiekunProduktu> OpiekunProduktus { get; set; } // 00:22 09.09.2022
        public virtual ICollection<Producent> Producents { get; set; } // 00:22 09.09.2022
        //public object OpiekunProducenta { get; internal set; }
        //public object Producent { get; internal set; }
    }
}
