import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../datasources/exercise_remote_datasource.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseRemoteDataSource _remote;

  ExerciseRepositoryImpl(this._remote);

  @override
  Future<List<Exercise>> searchByMuscle(String muscle) async {
    final models = await _remote.fetchByMuscle(muscle);
    return models
        .map((m) => Exercise(
              name: m.name,
              type: m.type,
              muscle: m.muscle,
              equipment: m.equipment,
              difficulty: m.difficulty,
              instructions: m.instructions,
            ))
        .toList();
  }

  @override
  Future<List<Exercise>> getFavorites() async => [];

  @override
  Future<void> toggleFavorite(Exercise exercise) async {}

  @override
  Future<bool> isFavorite(String name) async => false;
}