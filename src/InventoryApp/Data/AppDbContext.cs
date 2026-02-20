using Microsoft.EntityFrameworkCore;
using InventoryApp.Models;

namespace InventoryApp.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<Categoria> Categorias { get; set; }
    public DbSet<Proveedor> Proveedores { get; set; }
    public DbSet<Producto> Productos { get; set; }
    public DbSet<MovimientoStock> MovimientosStock { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configurar nombres de tablas en español
        modelBuilder.Entity<Categoria>().ToTable("Categorias");
        modelBuilder.Entity<Proveedor>().ToTable("Proveedores");
        modelBuilder.Entity<Producto>().ToTable("Productos");
        modelBuilder.Entity<MovimientoStock>().ToTable("MovimientosStock");

        // indices para busquedas frecuentes
        modelBuilder.Entity<Producto>()
            .HasIndex(p => p.Nombre)
            .HasDatabaseName("IX_Productos_Nombre");

        modelBuilder.Entity<Producto>()
            .HasIndex(p => p.IdCategoria)
            .HasDatabaseName("IX_Productos_IdCategoria");
    }

}