using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Producent
    {
        public Producent()
        {
            OpiekunProduktus = new HashSet<OpiekunProduktu>();  // // 00:22 09.09.2022
            Produkties = new HashSet<Produkty>(); // 00:22 09.09.2022
        }

        public int IdProducent { get; set; }
        public string Nazwa { get; set; }

        public virtual ICollection<OpiekunProduktu> OpiekunProduktus { get; set; } // 00:22 09.09.2022
        public virtual ICollection<Produkty> Produkties { get; set; } // 00:22 09.09.2022
        public virtual ICollection<Pracownicy> Pracownicies { get; set; } //tutaj
    }
}
