using System;
using System.Collections.Generic;

#nullable disable

namespace Projekt.DB
{
    public partial class Rabaty
    {
        public int IdRabaty { get; set; }
        public int? KlientId { get; set; }
        public int? Procent { get; set; }

        public virtual Klienci Klient { get; set; }
    }
}
