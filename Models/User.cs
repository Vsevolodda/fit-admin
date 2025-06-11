using System;
using System.Collections.Generic;

namespace FitAdmin.Models;

public partial class User
{
    public int UserId { get; set; }

    public string Login { get; set; } = null!;

    public string PasswordHash { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string FullName { get; set; } = null!;

    public int RoleId { get; set; }
    public string? Specialization { get; set; }
    public string? Phone { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual Role Role { get; set; } = null!;

    public bool IsRemoved { get; set; }

    public virtual ICollection<Schedule> Schedules { get; set; } = new List<Schedule>();

}
