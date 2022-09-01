using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class OpiekunProduktu
    {
        public OpiekunProduktu()
        {
            Produkties = new HashSet<Produkty>();
        }

        public int IdOpiekun { get; set; }
        public int? PracownicyId { get; set; }
        public int? ProducentId { get; set; }

        public virtual Pracownicy Pracownicy { get; set; }
        public virtual Producent Producent { get; set; }
        public virtual ICollection<Produkty> Produkties { get; set; }
    }
}
