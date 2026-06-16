import 'package:go_router/go_router.dart';
import '../../domain/entities/workout.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/create_workout/create_workout_screen.dart';
import '../../presentation/screens/workout_detail/workout_detail_screen.dart';
import '../../presentation/screens/add_exercise/add_exercise_screen.dart';
import '../../presentation/screens/detail/detail_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/create-workout',
      builder: (context, state) => const CreateWorkoutScreen(),
    ),
    GoRoute(
      path: '/workout/:id',
      builder: (context, state) {
        final workout = state.extra as Workout;
        return WorkoutDetailScreen(workout: workout);
      },
    ),
    GoRoute(
      path: '/add-exercise/:workoutId',
      builder: (context, state) {
        final workoutId = int.parse(state.pathParameters['workoutId']!);
        return AddExerciseScreen(workoutId: workoutId);
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final exercise = state.extra as dynamic;
        return DetailScreen(exercise: exercise);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
