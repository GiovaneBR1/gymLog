import 'package:flutter/material.dart';
import '../../domain/entities/exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback? onTap;

  const ExerciseCard({super.key, required this.exercise, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(exercise.name,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle:
            Text('${exercise.muscleLabel} • ${exercise.difficultyLabel}'),
        leading: CircleAvatar(
          child: Text(exercise.name[0].toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
