import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/workout_providers.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/strings.dart';
import '../../../domain/entities/workout.dart';

const _weekDays = [
  'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
];
const _weekDaysEn = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
];

class CreateWorkoutScreen extends ConsumerStatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  ConsumerState<CreateWorkoutScreen> createState() =>
      _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends ConsumerState<CreateWorkoutScreen> {
  final _nameController = TextEditingController();
  int _selectedDayIndex = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save(AppStrings s) async {
    if (!_formKey.currentState!.validate()) return;

    // Sempre salva em PT para manter consistência no banco
    final id = await ref.read(workoutNotifierProvider.notifier).createWorkout(
          Workout(
              name: _nameController.text.trim(),
              weekDay: _weekDays[_selectedDayIndex]),
        );

    if (mounted && id != -1) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workoutNotifierProvider);
    final lang = ref.watch(languageProvider);
    final s = lang == 'pt' ? AppStrings.pt : AppStrings.en;
    final days = lang == 'pt' ? _weekDays : _weekDaysEn;

    return Scaffold(
      appBar: AppBar(title: Text(s.newWorkout)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: s.workoutName,
                  hintText: s.workoutNameHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? s.workoutNameRequired
                    : null,
              ),
              const SizedBox(height: 24),
              Text(s.weekDay,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: days.asMap().entries.map((entry) {
                  final selected = entry.key == _selectedDayIndex;
                  return ChoiceChip(
                    label: Text(entry.value),
                    selected: selected,
                    onSelected: (_) =>
                        setState(() => _selectedDayIndex = entry.key),
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state is AsyncLoading ? null : () => _save(s),
                  child: state is AsyncLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(s.createWorkout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
