using System;
using System.Collections.Generic;

namespace FitAdmin.Models;

public partial class Booking
{
    public int BookingId { get; set; }

    public int ScheduleId { get; set; }

    public int ClientId { get; set; }

    public DateTime BookingDateTime { get; set; }

    public bool IsCancelled { get; set; }

    public virtual Client Client { get; set; } = null!;

    public virtual Schedule Schedule { get; set; } = null!;
}
