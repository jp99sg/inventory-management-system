using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace InventoryApp.Models;

public class MovimientoStock
{
    public int Id { get; set; }

    [Required]
    public int IdProducto {  get; set; }

    [Required]
    [StringLength(10)]
    public string Tipo { get; set; } = string.Empty; // ENTRADA O SALIDA

    [Required]
    [Range(1, int.MaxValue, ErrorMessage = "La cantidad debe ser mayor a 0")]
    public int Cantidad { get; set; }

    [StringLength(255)]
    public string? Motivo { get; set; }

    public DateTime Fecha { get; set; } = DateTime.UtcNow;

    // Navegacion
    [ForeignKey("IdProducto")]
    public Producto? Producto { get; set; } 
}