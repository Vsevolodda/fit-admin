namespace FitAdmin.Models;

public partial class Schedule
{
    public int ScheduleId { get; set; }

    public int WorkoutTypeId { get; set; }

    public int TrainerId { get; set; }

    public string? Room { get; set; }

    public DateTime ScheduledDateTime { get; set; }

    public int MaxParticipants { get; set; }

    public bool IsRemoved { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public int CurrentParticipants => Bookings.Where(b => !b.IsCancelled).Count();

    public virtual User Trainer { get; set; } = null!;

    public virtual WorkoutType WorkoutType { get; set; } = null!;

    public string TimeUntilStart => ScheduledDateTime < DateTime.Now
                ? "Завершена"
               : $"{(ScheduledDateTime - DateTime.Now).Days} дн. {(ScheduledDateTime - DateTime.Now).Hours:D2}:{(ScheduledDateTime - DateTime.Now).Minutes:D2}";
}
