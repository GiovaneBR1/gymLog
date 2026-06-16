import 'package:flutter/material.dart';
import 'package:gymlog/domain/entities/exercise.dart';

class DetailScreen extends StatelessWidget {
  final Exercise exercise;

  const DetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    Color difficultyColor() {
      switch (exercise.difficulty.toLowerCase()) {
        case 'beginner':
          return Colors.green;
        case 'intermediate':
          return Colors.orange;
        case 'expert':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: Text(exercise.muscleLabel),
                  avatar: const Icon(Icons.fitness_center, size: 16),
                ),
                Chip(
                  label: Text(exercise.type),
                  avatar: const Icon(Icons.category, size: 16),
                ),
                Chip(
                  label: Text(exercise.equipment),
                  avatar: const Icon(Icons.sports_gymnastics, size: 16),
                ),
                Chip(
                  label: Text(exercise.difficultyLabel),
                  backgroundColor: difficultyColor().withOpacity(0.15),
                  labelStyle: TextStyle(color: difficultyColor()),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Como fazer', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              exercise.instructions.isNotEmpty
                  ? exercise.instructions
                  : 'Sem instruções disponíveis.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}