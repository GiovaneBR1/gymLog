import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/workout.dart';

class WorkoutLocalDataSource {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gymlog.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE workouts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            week_day TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE workout_exercises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            workout_id INTEGER NOT NULL,
            exercise_name TEXT NOT NULL,
            muscle TEXT NOT NULL,
            sets INTEGER NOT NULL,
            reps INTEGER NOT NULL,
            FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    return db.insert('workouts', {
      'name': workout.name,
      'week_day': workout.weekDay,
    });
  }

  Future<void> deleteWorkout(int id) async {
    final db = await database;
    await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
    await db.delete('workout_exercises', where: 'workout_id = ?', whereArgs: [id]);
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final rows = await db.query('workouts', orderBy: 'id DESC');
    return rows
        .map((r) => Workout(
              id: r['id'] as int,
              name: r['name'] as String,
              weekDay: r['week_day'] as String,
            ))
        .toList();
  }

  Future<List<WorkoutExercise>> getExercisesForWorkout(int workoutId) async {
    final db = await database;
    final rows = await db.query(
      'workout_exercises',
      where: 'workout_id = ?',
      whereArgs: [workoutId],
    );
    return rows
        .map((r) => WorkoutExercise(
              id: r['id'] as int,
              workoutId: r['workout_id'] as int,
              exerciseName: r['exercise_name'] as String,
              muscle: r['muscle'] as String,
              sets: r['sets'] as int,
              reps: r['reps'] as int,
            ))
        .toList();
  }

  Future<void> insertWorkoutExercise(WorkoutExercise e) async {
    final db = await database;
    await db.insert('workout_exercises', {
      'workout_id': e.workoutId,
      'exercise_name': e.exerciseName,
      'muscle': e.muscle,
      'sets': e.sets,
      'reps': e.reps,
    });
  }

   Future<void> deleteWorkoutExercise(int id) async {
    final db = await database;
    await db.delete(
      'workout_exercises',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateWorkoutExercise(WorkoutExercise e) async {
    final db = await database;
    await db.update(
      'workout_exercises',
      {
        'sets': e.sets,
        'reps': e.reps,
      },
      where: 'id = ?',
      whereArgs: [e.id],
    );
  }
}