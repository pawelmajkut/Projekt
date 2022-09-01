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
        }

        public int IdPracownicy { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public string Stanowisko { get; set; }
        public string Pesel { get; set; }

        public virtual ICollection<OpiekunProduktu> OpiekunProduktus { get; set; }
    }
}
