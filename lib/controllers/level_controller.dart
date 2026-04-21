import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class LevelController {
  final storage = Hive.box("storage");

  late RxSet<int> completedLevels;
  late RxMap<int, int> levelScores;
  int currentLevel = 0;

  LevelController() {
    final storedCompletedLevels = storage.get('completedLevels') ?? <int>[];
    completedLevels = Set<int>.from(storedCompletedLevels).obs;

    final storedLevelScores = storage.get('levelScores') ?? <int, int>{};
    levelScores = Map<int, int>.from(storedLevelScores).obs;
  }

  void _save() {
    storage.put('completedLevels', completedLevels.toList());
    storage.put('levelScores', levelScores);
  }

  void markLevelCompleted(int level) {
    completedLevels.add(level);
    _save();
  }

  void updateLevelScore(int level, int score) {
    levelScores[level] = score;
    _save();
  }

  int? getLevelScore(int level) => levelScores[level];

  void updateCurrentLevel(int level) {
    currentLevel = level;
  }

  bool isLevelCompleted(int level) {
    return completedLevels.contains(level);
  }
}
