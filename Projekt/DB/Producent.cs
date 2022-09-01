using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Producent
    {
        public Producent()
        {
            OpiekunProduktus = new HashSet<OpiekunProduktu>();
            Produkties = new HashSet<Produkty>();
        }

        public int IdProducent { get; set; }
        public string Nazwa { get; set; }

        public virtual ICollection<OpiekunProduktu> OpiekunProduktus { get; set; }
        public virtual ICollection<Produkty> Produkties { get; set; }
    }
}
