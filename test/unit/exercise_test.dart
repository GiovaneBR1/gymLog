import 'package:flutter_test/flutter_test.dart';
import 'package:gymlog/data/models/exercise_model.dart';
import 'package:gymlog/domain/entities/exercise.dart';
import 'package:gymlog/domain/entities/workout.dart';

String _translateWeekDay(String ptDay, String lang) {
  if (lang == 'pt') return ptDay;
  const map = {
    'Segunda': 'Monday', 'Terça': 'Tuesday', 'Quarta': 'Wednesday',
    'Quinta': 'Thursday', 'Sexta': 'Friday', 'Sábado': 'Saturday',
    'Domingo': 'Sunday',
  };
  return map[ptDay] ?? ptDay;
}

void main() {
  group('ExerciseModel.fromJson', () {
    test('converte JSON corretamente', () {
      final json = {
        'name': 'Barbell Curl', 'type': 'strength', 'muscle': 'biceps',
        'equipment': 'barbell', 'difficulty': 'beginner',
        'instructions': 'Stand and curl.',
      };
      final model = ExerciseModel.fromJson(json);
      expect(model.name, 'Barbell Curl');
      expect(model.muscle, 'biceps');
    });

    test('campos nulos no JSON viram string vazia', () {
      final json = {
        'name': null, 'type': null, 'muscle': null,
        'equipment': null, 'difficulty': null, 'instructions': null,
      };
      final model = ExerciseModel.fromJson(json);
      expect(model.name, '');
      expect(model.muscle, '');
    });
  });

  group('Exercise labels', () {
    const exercise = Exercise(
      name: 'Squat', type: 'strength', muscle: 'quadriceps',
      equipment: 'barbell', difficulty: 'intermediate', instructions: '',
    );

    test('difficultyLabel traduz intermediate', () {
      expect(exercise.difficultyLabel, 'Intermediário');
    });

    test('muscleLabel traduz quadriceps', () {
      expect(exercise.muscleLabel, 'Quadríceps');
    });

    test('difficultyLabel traduz beginner', () {
      const e = Exercise(
        name: 'Push Up', type: 'strength', muscle: 'chest',
        equipment: 'body_only', difficulty: 'beginner', instructions: '',
      );
      expect(e.difficultyLabel, 'Iniciante');
    });
  });

  group('WorkoutExercise.copyWith', () {
    const ex = WorkoutExercise(
      id: 1, workoutId: 10, exerciseName: 'Bench Press',
      muscle: 'Peito', sets: 3, reps: 10,
    );

    test('altera sets mantendo o resto', () {
      final updated = ex.copyWith(sets: 5);
      expect(updated.sets, 5);
      expect(updated.reps, 10);
      expect(updated.exerciseName, 'Bench Press');
    });

    test('altera reps mantendo o resto', () {
      final updated = ex.copyWith(reps: 12);
      expect(updated.reps, 12);
      expect(updated.sets, 3);
    });
  });

  group('translateWeekDay', () {
    test('retorna em PT quando lang é pt', () {
      expect(_translateWeekDay('Segunda', 'pt'), 'Segunda');
      expect(_translateWeekDay('Domingo', 'pt'), 'Domingo');
    });

    test('traduz pra EN quando lang é en', () {
      expect(_translateWeekDay('Segunda', 'en'), 'Monday');
      expect(_translateWeekDay('Sábado', 'en'), 'Saturday');
      expect(_translateWeekDay('Domingo', 'en'), 'Sunday');
    });
  });

  group('Workout valores padrão', () {
    const workout = Workout(
      id: 1, name: 'Treino A', weekDay: 'Segunda',
    );

    test('completed padrão é false', () {
      expect(workout.completed, false);
    });

    test('sortOrder padrão é 0', () {
      expect(workout.sortOrder, 0);
    });
  });
}
