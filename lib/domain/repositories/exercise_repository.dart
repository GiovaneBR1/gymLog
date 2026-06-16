import '../entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> searchByMuscle(String muscle);
  Future<List<Exercise>> getFavorites();
  Future<void> toggleFavorite(Exercise exercise);
  Future<bool> isFavorite(String name);
}
