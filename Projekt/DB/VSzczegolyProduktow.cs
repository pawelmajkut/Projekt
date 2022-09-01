using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class VSzczegolyProduktow
    {
        public string NazwaProduktu { get; set; }
        public string Producent { get; set; }
        public string Kategoria { get; set; }
        public decimal Cena { get; set; }
        public int IlośćSztuk { get; set; }
    }
}
