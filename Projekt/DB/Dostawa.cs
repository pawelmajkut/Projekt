using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Dostawa
    {
        public Dostawa()
        {
            Koszyks = new HashSet<Koszyk>();
        }

        public int IdDostawa { get; set; }
        public string Dostawca { get; set; }
        public string RodzajDostawy { get; set; }
        public decimal CenaDostawy { get; set; }

        public virtual ICollection<Koszyk> Koszyks { get; set; }
    }
}
