using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Produkty
    {
        public Produkty()
        {
            RezerwacjeProduktóws = new HashSet<RezerwacjeProduktów>();
            WybraneProdukties = new HashSet<WybraneProdukty>();
        }

        public int IdProdukty { get; set; }
        public string Nazwa { get; set; }
        public string Opis { get; set; }
        public int? ProducentId { get; set; }
        public int? KategoriaId { get; set; }
        public int Ilość { get; set; }
        public decimal Cena { get; set; }
        public int? OpiekunProduktuId { get; set; }

        public virtual Kategorie Kategoria { get; set; }
        public virtual OpiekunProduktu OpiekunProduktu { get; set; }
        public virtual Producent Producent { get; set; }
        public virtual ICollection<RezerwacjeProduktów> RezerwacjeProduktóws { get; set; }
        public virtual ICollection<WybraneProdukty> WybraneProdukties { get; set; }
    }
}
