using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class WybraneProdukty
    {
        public int IdZamowienia { get; set; }
        public int? ProduktId { get; set; }
        public int Ilość { get; set; }
        public decimal? Suma { get; set; }
        public int? StatusId { get; set; }
        public int? KoszykId { get; set; }
        public int? Rabat { get; set; }

        public virtual Koszyk Koszyk { get; set; }
        public virtual Produkty Produkt { get; set; }
        public virtual Statusy Status { get; set; }
    }
}
