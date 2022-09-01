using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Koszyk
    {
        public Koszyk()
        {
            WybraneProdukties = new HashSet<WybraneProdukty>();
        }

        public int IdKoszyka { get; set; }
        public int? KlientId { get; set; }
        public DateTime DataZamówienia { get; set; }
        public decimal KwotaRazem { get; set; }
        public int? StatusId { get; set; }
        public int? Rabat { get; set; }
        public int? DostawaId { get; set; }
        public DateTime DataDostawy { get; set; }
        public int? StatusPłatnościId { get; set; }

        public virtual Dostawa Dostawa { get; set; }
        public virtual Klienci Klient { get; set; }
        public virtual Statusy Status { get; set; }
        public virtual Statusy StatusPłatności { get; set; }
        public virtual ICollection<WybraneProdukty> WybraneProdukties { get; set; }
    }
}
