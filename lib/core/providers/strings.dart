// Strings do app em PT e EN
class AppStrings {
  final String gymLog;
  final String newWorkout;
  final String noWorkoutsYet;
  final String tapToCreate;
  final String today;
  final String exercises;
  final String exercise;
  final String deleteWorkout;
  final String deleteWorkoutConfirm;
  final String cancel;
  final String delete;
  final String settings;
  final String darkMode;
  final String darkModeSubtitle;
  final String language;
  final String portuguese;
  final String english;
  final String about;
  final String searchExercises;
  final String selectMuscles;
  final String noResults;
  final String addToWorkout;
  final String sets;
  final String reps;
  final String addExercise;
  final String noExercisesYet;
  final String save;
  final String howTo;
  final String noInstructions;
  final String added;
  final String workoutName;
  final String workoutNameHint;
  final String workoutNameRequired;
  final String weekDay;
  final String createWorkout;

  const AppStrings({
    required this.gymLog,
    required this.newWorkout,
    required this.noWorkoutsYet,
    required this.tapToCreate,
    required this.today,
    required this.exercises,
    required this.exercise,
    required this.deleteWorkout,
    required this.deleteWorkoutConfirm,
    required this.cancel,
    required this.delete,
    required this.settings,
    required this.darkMode,
    required this.darkModeSubtitle,
    required this.language,
    required this.portuguese,
    required this.english,
    required this.about,
    required this.searchExercises,
    required this.selectMuscles,
    required this.noResults,
    required this.addToWorkout,
    required this.sets,
    required this.reps,
    required this.addExercise,
    required this.noExercisesYet,
    required this.save,
    required this.howTo,
    required this.noInstructions,
    required this.added,
    required this.workoutName,
    required this.workoutNameHint,
    required this.workoutNameRequired,
    required this.weekDay,
    required this.createWorkout,
  });

  static const pt = AppStrings(
    gymLog: 'GymLog',
    newWorkout: 'Novo treino',
    noWorkoutsYet: 'Nenhum treino ainda',
    tapToCreate: 'Toque no + para criar seu primeiro treino',
    today: 'Hoje',
    exercises: 'exercícios',
    exercise: 'exercício',
    deleteWorkout: 'Excluir treino?',
    deleteWorkoutConfirm: 'Isso vai remover todos os exercícios.',
    cancel: 'Cancelar',
    delete: 'Excluir',
    settings: 'Configurações',
    darkMode: 'Tema escuro',
    darkModeSubtitle: 'Alterna entre tema claro e escuro',
    language: 'Idioma',
    portuguese: 'Português',
    english: 'English',
    about: 'Sobre',
    searchExercises: 'Buscar Exercícios',
    selectMuscles: 'Selecione um ou mais músculos',
    noResults: 'Nenhum resultado',
    addToWorkout: 'Adicionar ao treino',
    sets: 'Séries',
    reps: 'Repetições',
    addExercise: 'Adicionar exercício',
    noExercisesYet: 'Nenhum exercício ainda',
    save: 'Salvar',
    howTo: 'Como fazer',
    noInstructions: 'Sem instruções disponíveis.',
    added: 'adicionado!',
    workoutName: 'Nome do treino',
    workoutNameHint: 'Ex: Treino A, Push, Peito e Tríceps...',
    workoutNameRequired: 'Dê um nome ao treino',
    weekDay: 'Dia da semana',
    createWorkout: 'Criar Treino',
  );

  static const en = AppStrings(
    gymLog: 'GymLog',
    newWorkout: 'New workout',
    noWorkoutsYet: 'No workouts yet',
    tapToCreate: 'Tap + to create your first workout',
    today: 'Today',
    exercises: 'exercises',
    exercise: 'exercise',
    deleteWorkout: 'Delete workout?',
    deleteWorkoutConfirm: 'This will remove all exercises.',
    cancel: 'Cancel',
    delete: 'Delete',
    settings: 'Settings',
    darkMode: 'Dark mode',
    darkModeSubtitle: 'Toggle between light and dark theme',
    language: 'Language',
    portuguese: 'Português',
    english: 'English',
    about: 'About',
    searchExercises: 'Search Exercises',
    selectMuscles: 'Select one or more muscles',
    noResults: 'No results',
    addToWorkout: 'Add to workout',
    sets: 'Sets',
    reps: 'Reps',
    addExercise: 'Add exercise',
    noExercisesYet: 'No exercises yet',
    save: 'Save',
    howTo: 'How to',
    noInstructions: 'No instructions available.',
    added: 'added!',
    workoutName: 'Workout name',
    workoutNameHint: 'E.g.: Workout A, Push, Chest & Triceps...',
    workoutNameRequired: 'Give your workout a name',
    weekDay: 'Day of the week',
    createWorkout: 'Create Workout',
  );
}
