namespace FitAdmin.Models;

public partial class WorkoutType
{
    public int WorkoutTypeId { get; set; }

    public string Name { get; set; } = null!;

    public bool IsRemoved { get; set; }

    public virtual ICollection<Schedule> Schedules { get; set; } = new List<Schedule>();
}
