import '../entities/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts();
  Future<int> createWorkout(Workout workout);
  Future<void> deleteWorkout(int id);
  Future<List<WorkoutExercise>> getExercisesForWorkout(int workoutId);
  Future<void> addExerciseToWorkout(WorkoutExercise exercise);
  Future<void> removeExerciseFromWorkout(int exerciseId);
  Future<void> updateExercise(WorkoutExercise exercise);
}
