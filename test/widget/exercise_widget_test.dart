import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gymlog/core/providers/workout_providers.dart';
import 'package:gymlog/domain/entities/workout.dart';
import 'package:gymlog/presentation/screens/home/home_screen.dart';
import 'package:gymlog/presentation/screens/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoRouter _testRouter(Widget home) => GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => home),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
        GoRoute(path: '/create-workout', builder: (_, __) => const Scaffold()),
        GoRoute(path: '/workout/:id', builder: (_, __) => const Scaffold()),
      ],
    );

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('HomeScreen exibe mensagem quando sem treinos', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          workoutsProvider.overrideWith((ref) async => <Workout>[]),
        ],
        child: MaterialApp.router(
          routerConfig: _testRouter(const HomeScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Nenhum treino ainda'), findsOneWidget);
  });

  testWidgets('HomeScreen exibe cards de treinos', (tester) async {
    final treinos = <Workout>[
      const Workout(id: 1, name: 'Treino A', weekDay: 'Segunda'),
      const Workout(id: 2, name: 'Treino B', weekDay: 'Quarta'),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          workoutsProvider.overrideWith((ref) async => treinos),
          workoutExercisesProvider
              .overrideWith((ref, id) async => <WorkoutExercise>[]),
        ],
        child: MaterialApp.router(
          routerConfig: _testRouter(const HomeScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Treino A'), findsOneWidget);
    expect(find.text('Treino B'), findsOneWidget);
  });

  testWidgets('SettingsScreen tem switch de tema', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: GoRouter(routes: [
            GoRoute(path: '/', builder: (_, __) => const SettingsScreen()),
          ]),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text('Tema escuro'), findsOneWidget);
  });
}
