import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/exercise_providers.dart';
import '../../../core/providers/workout_providers.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/strings.dart';
import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/workout.dart';

const _muscles = [
  'biceps', 'triceps', 'chest', 'lats', 'shoulders',
  'quadriceps', 'hamstrings', 'glutes', 'abdominals', 'calves',
  'forearms', 'traps', 'middle_back', 'lower_back',
];

const _musclesPT = {
  'biceps': 'Bíceps', 'triceps': 'Tríceps', 'chest': 'Peito',
  'lats': 'Dorsais', 'shoulders': 'Ombros', 'quadriceps': 'Quadríceps',
  'hamstrings': 'Posteriores', 'glutes': 'Glúteos', 'abdominals': 'Abdômen',
  'calves': 'Panturrilha', 'forearms': 'Antebraço', 'traps': 'Trapézio',
  'middle_back': 'Costas médias', 'lower_back': 'Lombar',
};

const _musclesEN = {
  'biceps': 'Biceps', 'triceps': 'Triceps', 'chest': 'Chest',
  'lats': 'Lats', 'shoulders': 'Shoulders', 'quadriceps': 'Quadriceps',
  'hamstrings': 'Hamstrings', 'glutes': 'Glutes', 'abdominals': 'Abs',
  'calves': 'Calves', 'forearms': 'Forearms', 'traps': 'Traps',
  'middle_back': 'Middle Back', 'lower_back': 'Lower Back',
};

class AddExerciseScreen extends ConsumerStatefulWidget {
  final int workoutId;

  const AddExerciseScreen({super.key, required this.workoutId});

  @override
  ConsumerState<AddExerciseScreen> createState() => _AddExerciseScreenState();
}


class _AddExerciseScreenState extends ConsumerState<AddExerciseScreen> {
  int _sets = 3;
  int _reps = 10;

  void _showAddDialog(Exercise exercise, AppStrings s) {
    _sets = 3;
    _reps = 10;

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
              Text(exercise.name,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(exercise.muscleLabel,
                  style: Theme.of(context).textTheme.bodyMedium),
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
                              onPressed: _sets > 1
                                  ? () => setModalState(() => _sets--)
                                  : null,
                            ),
                            Text('$_sets',
                                style:
                                    Theme.of(context).textTheme.titleLarge),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setModalState(() => _sets++),
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
                              onPressed: _reps > 1
                                  ? () => setModalState(() => _reps--)
                                  : null,
                            ),
                            Text('$_reps',
                                style:
                                    Theme.of(context).textTheme.titleLarge),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setModalState(() => _reps++),
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
                        .addExercise(WorkoutExercise(
                          workoutId: widget.workoutId,
                          exerciseName: exercise.name,
                          muscle: exercise.muscleLabel,
                          sets: _sets,
                          reps: _reps,
                        ));
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('${exercise.name} ${s.added}')),
                      );
                    }
                  },
                  child: Text(s.addToWorkout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final selectedMuscles = ref.watch(searchMuscleProvider);
    final results = ref.watch(exerciseSearchProvider);
    final lang = ref.watch(languageProvider);
    final s = lang == 'pt' ? AppStrings.pt : AppStrings.en;
    final muscleNames = lang == 'pt' ? _musclesPT : _musclesEN;

    return Scaffold(
      appBar: AppBar(title: Text(s.searchExercises)),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: _muscles.map((muscle) {
                final selected = selectedMuscles.contains(muscle);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(muscleNames[muscle] ?? muscle),
                    selected: selected,
                    onSelected: (_) {
                      final current = [...selectedMuscles];
                      if (selected) {
                        current.remove(muscle);
                      } else {
                        current.add(muscle);
                      }
                      ref.read(searchMuscleProvider.notifier).state =
                          current;
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: results.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
              data: (list) {
                if (selectedMuscles.isEmpty) {
                  return Center(child: Text(s.selectMuscles));
                }
                if (list.isEmpty) {
                  return Center(child: Text(s.noResults));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final ex = list[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(ex.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            '${ex.muscleLabel} • ${ex.difficultyLabel}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info_outline),
                              onPressed: () =>
                                  context.push('/detail', extra: ex),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => _showAddDialog(ex, s),
                            ),
                          ],
                        ),
                        onTap: () => _showAddDialog(ex, s),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  @override
void dispose() {
  // Limpa seleção ao sair
  ref.read(searchMuscleProvider.notifier).state = [];
  super.dispose();
}
}
