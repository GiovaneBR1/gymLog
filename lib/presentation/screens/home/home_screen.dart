import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/workout_providers.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/strings.dart';

const _weekDayOrder = [
  'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
];

String _todayWeekDay() {
  final day = DateTime.now().weekday;
  return _weekDayOrder[day - 1];
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutsProvider);
    final lang = ref.watch(languageProvider);
    final s = lang == 'pt' ? AppStrings.pt : AppStrings.en;
    final today = _todayWeekDay();

    return Scaffold(
      appBar: AppBar(
        title: Text(s.gymLog),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: s.newWorkout,
            onPressed: () => context.push('/create-workout'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: workouts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fitness_center, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(s.noWorkoutsYet,
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(s.tapToCreate,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          final sorted = [...list]..sort((a, b) {
              if (a.weekDay == today && b.weekDay != today) return -1;
              if (b.weekDay == today && a.weekDay != today) return 1;
              return _weekDayOrder.indexOf(a.weekDay)
                  .compareTo(_weekDayOrder.indexOf(b.weekDay));
            });

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sorted.length,
            itemBuilder: (context, i) {
              final workout = sorted[i];
              final isToday = workout.weekDay == today;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isToday
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: isToday
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    child: Text(
                      workout.weekDay.substring(0, 3),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? Theme.of(context).colorScheme.onPrimary
                            : null,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(workout.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      if (isToday) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            s.today,
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  subtitle: _WorkoutSubtitle(
                      workoutId: workout.id!, weekDay: workout.weekDay, s: s),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.chevron_right),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(s.deleteWorkout),
                              content: Text(
                                  '"${workout.name}": ${s.deleteWorkoutConfirm}'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text(s.cancel)),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text(s.delete,
                                        style: const TextStyle(
                                            color: Colors.red))),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            ref
                                .read(workoutNotifierProvider.notifier)
                                .deleteWorkout(workout.id!);
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () =>
                      context.push('/workout/${workout.id}', extra: workout),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _WorkoutSubtitle extends ConsumerWidget {
  final int workoutId;
  final String weekDay;
  final AppStrings s;

  const _WorkoutSubtitle(
      {required this.workoutId, required this.weekDay, required this.s});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(workoutExercisesProvider(workoutId));
    return exercises.when(
      loading: () => Text(weekDay),
      error: (_, __) => Text(weekDay),
      data: (list) => Text(
        '$weekDay • ${list.length} ${list.length != 1 ? s.exercises : s.exercise}',
      ),
    );
  }
}
