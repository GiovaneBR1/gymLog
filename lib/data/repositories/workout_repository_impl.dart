import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/workout_local_datasource.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutLocalDataSource _local;

  WorkoutRepositoryImpl(this._local);

  @override
  Future<List<Workout>> getWorkouts() => _local.getWorkouts();

  @override
  Future<int> createWorkout(Workout workout) => _local.insertWorkout(workout);

  @override
  Future<void> deleteWorkout(int id) => _local.deleteWorkout(id);

  @override
  Future<List<WorkoutExercise>> getExercisesForWorkout(int workoutId) =>
      _local.getExercisesForWorkout(workoutId);

  @override
  Future<void> addExerciseToWorkout(WorkoutExercise exercise) =>
      _local.insertWorkoutExercise(exercise);

  @override
  Future<void> removeExerciseFromWorkout(int exerciseId) =>
      _local.deleteWorkoutExercise(exerciseId);

  @override
  Future<void> updateExercise(WorkoutExercise exercise) =>
      _local.updateWorkoutExercise(exercise);
}
