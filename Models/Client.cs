namespace FitAdmin.Models;

public partial class Client
{
    public int ClientId { get; set; }

    public string FullName { get; set; } = null!;

    public DateOnly DateOfBirth { get; set; }

    public string Phone { get; set; } = null!;

    public string? Email { get; set; }

    public string? Address { get; set; }

    public byte[]? Photo { get; set; }

    public string? MedicalNotes { get; set; }
    
    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }
    public bool IsRemoved { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual ICollection<Membership> Memberships { get; set; } = new List<Membership>();

     public string ActiveMembership
    {
        get
        {
            var activeMembership = Memberships
                .Where(m => m.EndDate >= DateOnly.FromDateTime(DateTime.Today) && m.StartDate <= DateOnly.FromDateTime(DateTime.Today))
                .OrderByDescending(m => m.EndDate)
                .FirstOrDefault();

            return activeMembership != null
                ? $"{activeMembership.MembershipType?.Name} (до {activeMembership.EndDate:dd.MM.yyyy})"
                : "Нет активного абонемента";
        }
    }
}
