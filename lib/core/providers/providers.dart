import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/exercise_remote_datasource.dart';
import '../../data/datasources/exercise_local_datasource.dart';
import '../../data/datasources/workout_local_datasource.dart';
import '../../data/repositories/exercise_repository_impl.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/workout_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final remoteDataSourceProvider = Provider<ExerciseRemoteDataSource>(
  (ref) => ExerciseRemoteDataSource(ref.read(dioProvider)),
);

final localDataSourceProvider = Provider<ExerciseLocalDataSource>(
  (ref) => ExerciseLocalDataSource(),
);

final workoutLocalDataSourceProvider = Provider<WorkoutLocalDataSource>(
  (ref) => WorkoutLocalDataSource(),
);

final exerciseRepositoryProvider = Provider<ExerciseRepository>(
  (ref) => ExerciseRepositoryImpl(
    ref.read(remoteDataSourceProvider),
  ),
);

final workoutRepositoryProvider = Provider<WorkoutRepository>(
  (ref) => WorkoutRepositoryImpl(ref.read(workoutLocalDataSourceProvider)),
);
