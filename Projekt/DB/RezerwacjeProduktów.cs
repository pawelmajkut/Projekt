using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class RezerwacjeProduktów
    {
        public int IdRezerwacje { get; set; }
        public int? KlientId { get; set; }
        public int? ProduktId { get; set; }
        public int? StatusId { get; set; }
        public DateTime DataKoncaRezerwacji { get; set; }

        public virtual Klienci Klient { get; set; }
        public virtual Produkty Produkt { get; set; }
        public virtual Statusy Status { get; set; }
    }
}
