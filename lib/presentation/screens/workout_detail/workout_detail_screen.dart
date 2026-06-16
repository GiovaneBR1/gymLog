import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/workout_providers.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/strings.dart';
import '../../../domain/entities/workout.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  void _showEditDialog(BuildContext context, WidgetRef ref, WorkoutExercise ex, AppStrings s) {
    int sets = ex.sets;
    int reps = ex.reps;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ex.exerciseName,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(ex.muscle, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.sets),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: sets > 1
                                  ? () => setModalState(() => sets--)
                                  : null,
                            ),
                            Text('$sets',
                                style: Theme.of(context).textTheme.titleLarge),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setModalState(() => sets++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.reps),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: reps > 1
                                  ? () => setModalState(() => reps--)
                                  : null,
                            ),
                            Text('$reps',
                                style: Theme.of(context).textTheme.titleLarge),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setModalState(() => reps++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await ref
                        .read(workoutNotifierProvider.notifier)
                        .updateExercise(ex.copyWith(sets: sets, reps: reps));
                  },
                  child: Text(s.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(workoutExercisesProvider(workout.id!));
    final lang = ref.watch(languageProvider);
    final s = lang == 'pt' ? AppStrings.pt : AppStrings.en;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(workout.name),
            Text(workout.weekDay,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white70)),
          ],
        ),
      ),
      body: exercises.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_circle_outline,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(s.noExercisesYet,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final ex = list[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(ex.exerciseName,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(ex.muscle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => _showEditDialog(context, ref, ex, s),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${ex.sets}x${ex.reps}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.edit,
                                  size: 12,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 20),
                        onPressed: () => ref
                            .read(workoutNotifierProvider.notifier)
                            .removeExercise(ex.id!, workout.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-exercise/${workout.id}'),
        icon: const Icon(Icons.add),
        label: Text(s.addExercise),
      ),
    );
  }
}
