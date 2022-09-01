using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace Projekt.DB
{
    public partial class SklepInternetowy_BAJTContext : DbContext
    {
        public SklepInternetowy_BAJTContext()
        {
        }

        public SklepInternetowy_BAJTContext(DbContextOptions<SklepInternetowy_BAJTContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Dostawa> Dostawas { get; set; }
        public virtual DbSet<Kategorie> Kategories { get; set; }
        public virtual DbSet<Klienci> Kliencis { get; set; }
        public virtual DbSet<Koszyk> Koszyks { get; set; }
        public virtual DbSet<OpiekunProduktu> OpiekunProduktus { get; set; }
        public virtual DbSet<Pracownicy> Pracownicies { get; set; }
        public virtual DbSet<Producent> Producents { get; set; }
        public virtual DbSet<Produkty> Produkties { get; set; }
        public virtual DbSet<Rabaty> Rabaties { get; set; }
        public virtual DbSet<RezerwacjeProduktów> RezerwacjeProduktóws { get; set; }
        public virtual DbSet<Statusy> Statusies { get; set; }
        public virtual DbSet<VSzczegolyProduktow> VSzczegolyProduktows { get; set; }
        public virtual DbSet<VZakupyKlientówPowyżejKwoty1000> VZakupyKlientówPowyżejKwoty1000s { get; set; }
        public virtual DbSet<WybraneProdukty> WybraneProdukties { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=SIGMA\\SQLEXPRESS; Database=SklepInternetowy_BAJT; trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Polish_100_CI_AS");

            modelBuilder.Entity<Dostawa>(entity =>
            {
                entity.HasKey(e => e.IdDostawa)
                    .HasName("PK__Dostawa__6D6331127029D2CE");

                entity.ToTable("Dostawa");

                entity.Property(e => e.IdDostawa).HasColumnName("ID_dostawa");

                entity.Property(e => e.CenaDostawy)
                    .HasColumnType("decimal(8, 2)")
                    .HasColumnName("Cena_dostawy");

                entity.Property(e => e.Dostawca)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.RodzajDostawy)
                    .IsRequired()
                    .HasMaxLength(250)
                    .HasColumnName("Rodzaj_dostawy");
            });

            modelBuilder.Entity<Kategorie>(entity =>
            {
                entity.HasKey(e => e.IdKategorie)
                    .HasName("PK__Kategori__422FFED9FC266CFA");

                entity.ToTable("Kategorie");

                entity.HasIndex(e => e.Nazwa, "UQ__Kategori__602223FF518802F4")
                    .IsUnique();

                entity.Property(e => e.IdKategorie).HasColumnName("ID_kategorie");

                entity.Property(e => e.Nazwa)
                    .IsRequired()
                    .HasMaxLength(250);
            });

            modelBuilder.Entity<Klienci>(entity =>
            {
                entity.HasKey(e => e.IdKlienci)
                    .HasName("PK__Klienci__D3E2C16A1071DA0A");

                entity.ToTable("Klienci");

                entity.Property(e => e.IdKlienci).HasColumnName("ID_klienci");

                entity.Property(e => e.AdresZam)
                    .IsRequired()
                    .HasMaxLength(250)
                    .HasColumnName("Adres_zam");

                entity.Property(e => e.DataUrodzenia)
                    .HasColumnType("datetime")
                    .HasColumnName("Data_urodzenia");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.Imię)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.KodPocztowy)
                    .IsRequired()
                    .HasMaxLength(250)
                    .HasColumnName("Kod_pocztowy");

                entity.Property(e => e.Nazwisko)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.TelKom)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasColumnName("Tel_kom");
            });

            modelBuilder.Entity<Koszyk>(entity =>
            {
                entity.HasKey(e => e.IdKoszyka)
                    .HasName("PK__Koszyk__AD9F6BB8A0A7D818");

                entity.ToTable("Koszyk");

                entity.Property(e => e.IdKoszyka).HasColumnName("ID_koszyka");

                entity.Property(e => e.DataDostawy)
                    .HasColumnType("datetime")
                    .HasColumnName("Data_dostawy");

                entity.Property(e => e.DataZamówienia)
                    .HasColumnType("datetime")
                    .HasColumnName("Data_zamówienia");

                entity.Property(e => e.DostawaId).HasColumnName("DostawaID");

                entity.Property(e => e.KlientId).HasColumnName("KlientID");

                entity.Property(e => e.KwotaRazem)
                    .HasColumnType("decimal(8, 2)")
                    .HasColumnName("Kwota_razem");

                entity.Property(e => e.Rabat).HasDefaultValueSql("((0))");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");

                entity.Property(e => e.StatusPłatnościId).HasColumnName("Status_płatnościID");

                entity.HasOne(d => d.Dostawa)
                    .WithMany(p => p.Koszyks)
                    .HasForeignKey(d => d.DostawaId)
                    .HasConstraintName("FK__Koszyk__DostawaI__403A8C7D");

                entity.HasOne(d => d.Klient)
                    .WithMany(p => p.Koszyks)
                    .HasForeignKey(d => d.KlientId)
                    .HasConstraintName("FK__Koszyk__KlientID__3C69FB99");

                entity.HasOne(d => d.Status)
                    .WithMany(p => p.KoszykStatuses)
                    .HasForeignKey(d => d.StatusId)
                    .HasConstraintName("FK__Koszyk__StatusID__3D5E1FD2");

                entity.HasOne(d => d.StatusPłatności)
                    .WithMany(p => p.KoszykStatusPłatnościs)
                    .HasForeignKey(d => d.StatusPłatnościId)
                    .HasConstraintName("FK__Koszyk__Status_p__412EB0B6");
            });

            modelBuilder.Entity<OpiekunProduktu>(entity =>
            {
                entity.HasKey(e => e.IdOpiekun)
                    .HasName("PK__Opiekun___CA8AF088AEFDB3A1");

                entity.ToTable("Opiekun_produktu");

                entity.Property(e => e.IdOpiekun).HasColumnName("ID_opiekun");

                entity.Property(e => e.PracownicyId).HasColumnName("PracownicyID");

                entity.Property(e => e.ProducentId).HasColumnName("ProducentID");

                entity.HasOne(d => d.Pracownicy)
                    .WithMany(p => p.OpiekunProduktus)
                    .HasForeignKey(d => d.PracownicyId)
                    .HasConstraintName("FK__Opiekun_p__Praco__2C3393D0");

                entity.HasOne(d => d.Producent)
                    .WithMany(p => p.OpiekunProduktus)
                    .HasForeignKey(d => d.ProducentId)
                    .HasConstraintName("FK__Opiekun_p__Produ__2D27B809");
            });

            modelBuilder.Entity<Pracownicy>(entity =>
            {
                entity.HasKey(e => e.IdPracownicy)
                    .HasName("PK__Pracowni__DEF469E815683253");

                entity.ToTable("Pracownicy");

                entity.Property(e => e.IdPracownicy).HasColumnName("ID_pracownicy");

                entity.Property(e => e.Imię)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.Nazwisko)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.Pesel)
                    .IsRequired()
                    .HasMaxLength(11)
                    .HasColumnName("PESEL");

                entity.Property(e => e.Stanowisko)
                    .IsRequired()
                    .HasMaxLength(250);
            });

            modelBuilder.Entity<Producent>(entity =>
            {
                entity.HasKey(e => e.IdProducent)
                    .HasName("PK__Producen__9FB82AB62FCC4862");

                entity.ToTable("Producent");

                entity.HasIndex(e => e.Nazwa, "UQ__Producen__602223FFCD2C9163")
                    .IsUnique();

                entity.Property(e => e.IdProducent).HasColumnName("ID_producent");

                entity.Property(e => e.Nazwa)
                    .IsRequired()
                    .HasMaxLength(250);
            });

            modelBuilder.Entity<Produkty>(entity =>
            {
                entity.HasKey(e => e.IdProdukty)
                    .HasName("PK__Produkty__879B87B19651A5F4");

                entity.ToTable("Produkty");

                entity.HasIndex(e => e.Nazwa, "UQ__Produkty__602223FF6FFD0DFC")
                    .IsUnique();

                entity.Property(e => e.IdProdukty).HasColumnName("ID_produkty");

                entity.Property(e => e.Cena).HasColumnType("decimal(8, 2)");

                entity.Property(e => e.KategoriaId).HasColumnName("KategoriaID");

                entity.Property(e => e.Nazwa)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.OpiekunProduktuId).HasColumnName("OpiekunProduktuID");

                entity.Property(e => e.Opis).HasMaxLength(250);

                entity.Property(e => e.ProducentId).HasColumnName("ProducentID");

                entity.HasOne(d => d.Kategoria)
                    .WithMany(p => p.Produkties)
                    .HasForeignKey(d => d.KategoriaId)
                    .HasConstraintName("FK__Produkty__Katego__31EC6D26");

                entity.HasOne(d => d.OpiekunProduktu)
                    .WithMany(p => p.Produkties)
                    .HasForeignKey(d => d.OpiekunProduktuId)
                    .HasConstraintName("FK__Produkty__Opieku__32E0915F");

                entity.HasOne(d => d.Producent)
                    .WithMany(p => p.Produkties)
                    .HasForeignKey(d => d.ProducentId)
                    .HasConstraintName("FK__Produkty__Produc__30F848ED");
            });

            modelBuilder.Entity<Rabaty>(entity =>
            {
                entity.HasKey(e => e.IdRabaty)
                    .HasName("PK__Rabaty__E8079A4BCAD1E3A4");

                entity.ToTable("Rabaty");

                entity.Property(e => e.IdRabaty).HasColumnName("ID_rabaty");

                entity.Property(e => e.KlientId).HasColumnName("KlientID");

                entity.Property(e => e.Procent).HasDefaultValueSql("((5))");

                entity.HasOne(d => d.Klient)
                    .WithMany(p => p.Rabaties)
                    .HasForeignKey(d => d.KlientId)
                    .HasConstraintName("FK__Rabaty__KlientID__4F7CD00D");
            });

            modelBuilder.Entity<RezerwacjeProduktów>(entity =>
            {
                entity.HasKey(e => e.IdRezerwacje)
                    .HasName("PK__Rezerwac__8B578F979BFF8A15");

                entity.ToTable("Rezerwacje_produktów");

                entity.Property(e => e.IdRezerwacje).HasColumnName("ID_rezerwacje");

                entity.Property(e => e.DataKoncaRezerwacji)
                    .HasColumnType("datetime")
                    .HasColumnName("Data_konca_rezerwacji");

                entity.Property(e => e.KlientId).HasColumnName("KlientID");

                entity.Property(e => e.ProduktId).HasColumnName("ProduktID");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");

                entity.HasOne(d => d.Klient)
                    .WithMany(p => p.RezerwacjeProduktóws)
                    .HasForeignKey(d => d.KlientId)
                    .HasConstraintName("FK__Rezerwacj__Klien__4AB81AF0");

                entity.HasOne(d => d.Produkt)
                    .WithMany(p => p.RezerwacjeProduktóws)
                    .HasForeignKey(d => d.ProduktId)
                    .HasConstraintName("FK__Rezerwacj__Produ__4BAC3F29");

                entity.HasOne(d => d.Status)
                    .WithMany(p => p.RezerwacjeProduktóws)
                    .HasForeignKey(d => d.StatusId)
                    .HasConstraintName("FK__Rezerwacj__Statu__4CA06362");
            });

            modelBuilder.Entity<Statusy>(entity =>
            {
                entity.HasKey(e => e.IdStatusy)
                    .HasName("PK__Statusy__C7FAFCB47676AD92");

                entity.ToTable("Statusy");

                entity.HasIndex(e => e.Nazwa, "UQ__Statusy__602223FF9E04D2C4")
                    .IsUnique();

                entity.Property(e => e.IdStatusy).HasColumnName("ID_statusy");

                entity.Property(e => e.Nazwa)
                    .IsRequired()
                    .HasMaxLength(250);
            });

            modelBuilder.Entity<VSzczegolyProduktow>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("v_SzczegolyProduktow");

                entity.Property(e => e.Cena).HasColumnType("decimal(8, 2)");

                entity.Property(e => e.IlośćSztuk).HasColumnName("Ilość_Sztuk");

                entity.Property(e => e.Kategoria).HasMaxLength(250);

                entity.Property(e => e.NazwaProduktu)
                    .IsRequired()
                    .HasMaxLength(250)
                    .HasColumnName("Nazwa_Produktu");

                entity.Property(e => e.Producent).HasMaxLength(250);
            });

            modelBuilder.Entity<VZakupyKlientówPowyżejKwoty1000>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("v_ZakupyKlientówPowyżejKwoty1000");

                entity.Property(e => e.ImięNazwisko)
                    .HasMaxLength(501)
                    .HasColumnName("Imię_Nazwisko");

                entity.Property(e => e.Zapłacono)
                    .HasColumnType("decimal(8, 2)")
                    .HasColumnName("ZAPŁACONO");
            });

            modelBuilder.Entity<WybraneProdukty>(entity =>
            {
                entity.HasKey(e => e.IdZamowienia)
                    .HasName("PK__Wybrane___7BF8C9E34DB9CE95");

                entity.ToTable("Wybrane_produkty");

                entity.Property(e => e.IdZamowienia).HasColumnName("ID_zamowienia");

                entity.Property(e => e.KoszykId).HasColumnName("koszykID");

                entity.Property(e => e.ProduktId).HasColumnName("produktID");

                entity.Property(e => e.Rabat).HasDefaultValueSql("((0))");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");

                entity.Property(e => e.Suma).HasColumnType("decimal(8, 2)");

                entity.HasOne(d => d.Koszyk)
                    .WithMany(p => p.WybraneProdukties)
                    .HasForeignKey(d => d.KoszykId)
                    .HasConstraintName("FK__Wybrane_p__koszy__45F365D3");

                entity.HasOne(d => d.Produkt)
                    .WithMany(p => p.WybraneProdukties)
                    .HasForeignKey(d => d.ProduktId)
                    .HasConstraintName("FK__Wybrane_p__produ__440B1D61");

                entity.HasOne(d => d.Status)
                    .WithMany(p => p.WybraneProdukties)
                    .HasForeignKey(d => d.StatusId)
                    .HasConstraintName("FK__Wybrane_p__Statu__44FF419A");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
