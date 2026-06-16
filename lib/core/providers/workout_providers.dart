import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/workout.dart';
import 'providers.dart';

final workoutsProvider = FutureProvider<List<Workout>>((ref) {
  return ref.read(workoutRepositoryProvider).getWorkouts();
});

final workoutExercisesProvider =
    FutureProvider.family<List<WorkoutExercise>, int>((ref, workoutId) {
  return ref.read(workoutRepositoryProvider).getExercisesForWorkout(workoutId);
});

class WorkoutNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  WorkoutNotifier(this._ref) : super(const AsyncData(null));

  Future<int> createWorkout(Workout workout) async {
    state = const AsyncLoading();
    try {
      final id = await _ref.read(workoutRepositoryProvider).createWorkout(workout);
      _ref.invalidate(workoutsProvider);
      state = const AsyncData(null);
      return id;
    } catch (e, st) {
      state = AsyncError(e, st);
      return -1;
    }
  }

  Future<void> deleteWorkout(int id) async {
    await _ref.read(workoutRepositoryProvider).deleteWorkout(id);
    _ref.invalidate(workoutsProvider);
  }

  Future<void> addExercise(WorkoutExercise exercise) async {
    await _ref.read(workoutRepositoryProvider).addExerciseToWorkout(exercise);
    _ref.invalidate(workoutExercisesProvider(exercise.workoutId));
    _ref.invalidate(workoutsProvider);
  }

  Future<void> removeExercise(int exerciseId, int workoutId) async {
    await _ref.read(workoutRepositoryProvider).removeExerciseFromWorkout(exerciseId);
    _ref.invalidate(workoutExercisesProvider(workoutId));
    _ref.invalidate(workoutsProvider);
  }

  Future<void> updateExercise(WorkoutExercise exercise) async {
    await _ref.read(workoutRepositoryProvider).updateExercise(exercise);
    _ref.invalidate(workoutExercisesProvider(exercise.workoutId));
  }
}

final workoutNotifierProvider =
    StateNotifierProvider<WorkoutNotifier, AsyncValue<void>>(
  (ref) => WorkoutNotifier(ref),
);
