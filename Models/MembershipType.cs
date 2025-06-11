using System;
using System.Collections.Generic;

namespace FitAdmin.Models;

public partial class MembershipType
{
    public int MembershipTypeId { get; set; }

    public string Name { get; set; } = null!;

    public decimal Price { get; set; }

    public int DurationDays { get; set; }

    public string? Restrictions { get; set; }
    public bool IsRemoved { get; set; }

    public virtual ICollection<Membership> Memberships { get; set; } = new List<Membership>();

    public string NameWithDuration => $"{Name} ({DurationDays} дней)";
}
