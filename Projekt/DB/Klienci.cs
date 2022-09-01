using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Klienci
    {
        public Klienci()
        {
            Koszyks = new HashSet<Koszyk>();
            Rabaties = new HashSet<Rabaty>();
            RezerwacjeProduktóws = new HashSet<RezerwacjeProduktów>();
        }

        public int IdKlienci { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public DateTime DataUrodzenia { get; set; }
        public string AdresZam { get; set; }
        public string KodPocztowy { get; set; }
        public string Email { get; set; }
        public string TelKom { get; set; }

        public virtual ICollection<Koszyk> Koszyks { get; set; }
        public virtual ICollection<Rabaty> Rabaties { get; set; }
        public virtual ICollection<RezerwacjeProduktów> RezerwacjeProduktóws { get; set; }
    }
}
