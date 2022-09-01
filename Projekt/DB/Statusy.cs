using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Statusy
    {
        public Statusy()
        {
            KoszykStatusPłatnościs = new HashSet<Koszyk>();
            KoszykStatuses = new HashSet<Koszyk>();
            RezerwacjeProduktóws = new HashSet<RezerwacjeProduktów>();
            WybraneProdukties = new HashSet<WybraneProdukty>();
        }

        public int IdStatusy { get; set; }
        public string Nazwa { get; set; }

        public virtual ICollection<Koszyk> KoszykStatusPłatnościs { get; set; }
        public virtual ICollection<Koszyk> KoszykStatuses { get; set; }
        public virtual ICollection<RezerwacjeProduktów> RezerwacjeProduktóws { get; set; }
        public virtual ICollection<WybraneProdukty> WybraneProdukties { get; set; }
    }
}
