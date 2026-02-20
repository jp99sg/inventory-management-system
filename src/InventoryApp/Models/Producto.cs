using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace InventoryApp.Models;

public class Producto
{
    public int Id { get; set; }

    [Required(ErrorMessage = "El nombre es obligatorio")]
    [StringLength(200, ErrorMessage = "Maximo 200 caracteres")]
    [Display(Name = "Nombre")]
    public string Nombre { get; set; } = string.Empty;

    [StringLength(500)]
    [Display(Name = "Descripcion")]
    public string? Descripcion {  get; set; }

    [Required(ErrorMessage = "El precio es obligatorio")]
    [Range(0, double.MaxValue, ErrorMessage = "El precio no puede ser negativo")]
    [Column(TypeName = "decimal(18,2)")]
    [Display(Name = "Precio")]
    public decimal Precio {  get; set; }

    [Range(0, int.MaxValue, ErrorMessage = "El stock no puede ser negativo")]
    [Display(Name = "Stock actual")]
    public int Stock { get; set; } = 0;

    [Range(0, int.MaxValue)]
    [Display(Name = "Stock minimo")]
    public int StockMinimo { get; set; } = 5;

    [Required(ErrorMessage = "La categoria es obligatoria")]
    [Display(Name = "Categoria")]
    public int IdCategoria { get; set; }

    [Display(Name = "Proveedor")]
    public int? IdProveedor { get; set; }

    public bool Activo { get; set; } = true;

    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;

    public DateTime? FechaActualizacion {  get; set; }

    // Navegacion
    [ForeignKey("IdCategoria")]
    public Categoria? Categoria {  get; set; }

    [ForeignKey("IdProveedor")]
    public Proveedor? Proveedor { get; set; }

    public ICollection<MovimientoStock>? Movimientos {  get; set; }

    // Propiedad calculada (no se mapea a BD)
    public bool TieneStockBajo => Stock <= StockMinimo;
}