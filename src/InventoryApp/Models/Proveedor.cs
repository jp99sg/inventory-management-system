using System.ComponentModel.DataAnnotations;

namespace InventoryApp.Models;

public class Proveedor
{
    public int Id { get; set; }

    [Required(ErrorMessage = "El nombre es obligatorio")]
    [StringLength(150)]
    [Display(Name = "Nombre")]
    public string Nombre { get; set; } = string.Empty;

    [StringLength(100)]
    [Display(Name = "Contacto")]
    public string? Contacto { get; set; }

    [StringLength(20)]
    [Display(Name = "Telefono")]
    public string? Telefono { get; set; }

    [EmailAddress(ErrorMessage = "Email no valido")]
    [StringLength(150)]
    [Display(Name = "Email")]
    public string? Email { get; set; }

    public bool Activo { get; set; } = true;

    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;

    // Navegacion
    public ICollection<Producto>? Productos { get; set; }
}