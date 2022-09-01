using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Kategorie
    {
        public Kategorie()
        {
            Produkties = new HashSet<Produkty>();
        }

        public int IdKategorie { get; set; }
        public string Nazwa { get; set; }

        public virtual ICollection<Produkty> Produkties { get; set; }
    }
}
