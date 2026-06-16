class Exercise {
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;
  final bool isFavorite;

  const Exercise({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
    this.isFavorite = false,
  });

  Exercise copyWith({bool? isFavorite}) {
    return Exercise(
      name: name,
      type: type,
      muscle: muscle,
      equipment: equipment,
      difficulty: difficulty,
      instructions: instructions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Retorna label de dificuldade em português
  String get difficultyLabel {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return 'Iniciante';
      case 'intermediate':
        return 'Intermediário';
      case 'expert':
        return 'Avançado';
      default:
        return difficulty;
    }
  }

  /// Retorna label do músculo em português
  String get muscleLabel {
    const map = {
      'abdominals': 'Abdômen',
      'abductors': 'Abdutores',
      'adductors': 'Adutores',
      'biceps': 'Bíceps',
      'calves': 'Panturrilha',
      'chest': 'Peito',
      'forearms': 'Antebraço',
      'glutes': 'Glúteos',
      'hamstrings': 'Posteriores',
      'lats': 'Dorsais',
      'lower_back': 'Lombar',
      'middle_back': 'Costas médias',
      'neck': 'Pescoço',
      'quadriceps': 'Quadríceps',
      'shoulders': 'Ombros',
      'traps': 'Trapézio',
      'triceps': 'Tríceps',
    };
    return map[muscle.toLowerCase()] ?? muscle;
  }
}
