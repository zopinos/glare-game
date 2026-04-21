import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class LevelController {
  final storage = Hive.box("storage");

  RxSet<int> completedLevels;
  RxMap<int, int> levelScores;
  int currentLevel = 0;

  LevelController()
    : completedLevels = <int>{}.obs,
      levelScores = <int, int>{}.obs {
    if (storage.get('completedLevels') == null) {
      storage.put('completedLevels', <int>[]);
    }
    completedLevels.value = Set<int>.from(storage.get('completedLevels'));

    if (storage.get('levelScores') == null) {
      storage.put('levelScores', <int, int>{});
    }
    levelScores.value = Map<int, int>.from(storage.get('levelScores'));
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
