using System;
using System.Collections.Generic;

namespace FitAdmin.Models;

public partial class Membership
{
    public int MembershipId { get; set; }

    public int ClientId { get; set; }

    public int MembershipTypeId { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly EndDate { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual Client Client { get; set; } = null!;

    public virtual MembershipType MembershipType { get; set; } = null!;
}
