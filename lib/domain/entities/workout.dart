class WorkoutExercise {
  final int? id;
  final int workoutId;
  final String exerciseName;
  final String muscle;
  final int sets;
  final int reps;

  const WorkoutExercise({
    this.id,
    required this.workoutId,
    required this.exerciseName,
    required this.muscle,
    required this.sets,
    required this.reps,
  });

  WorkoutExercise copyWith({int? sets, int? reps}) {
    return WorkoutExercise(
      id: id,
      workoutId: workoutId,
      exerciseName: exerciseName,
      muscle: muscle,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
    );
  }
}

class Workout {
  final int? id;
  final String name;
  final String weekDay;
  final List<WorkoutExercise> exercises;
  final int sortOrder;
  final bool completed;

  const Workout({
    this.id,
    required this.name,
    required this.weekDay,
    this.exercises = const [],
    this.sortOrder = 0,
    this.completed = false,
  });

  Workout copyWith({
    List<WorkoutExercise>? exercises,
    int? sortOrder,
    bool? completed,
  }) {
    return Workout(
      id: id,
      name: name,
      weekDay: weekDay,
      exercises: exercises ?? this.exercises,
      sortOrder: sortOrder ?? this.sortOrder,
      completed: completed ?? this.completed,
    );
  }
}