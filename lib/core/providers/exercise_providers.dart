import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/exercise.dart';
import 'providers.dart';

final searchMuscleProvider = StateProvider<List<String>>((ref) => []);

final exerciseSearchProvider = FutureProvider<List<Exercise>>((ref) async {
  final muscles = ref.watch(searchMuscleProvider);
  if (muscles.isEmpty) return [];
  final repo = ref.read(exerciseRepositoryProvider);
  final results = await Future.wait(muscles.map((m) => repo.searchByMuscle(m)));
  return results.expand((list) => list).toList();
});
