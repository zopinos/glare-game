class LevelService {
  final int totalLevels = 3;
  final Set<int> completedLevels = <int>{};
  final Map<int, int> levelScores = <int, int>{0: 0, 1: 0, 2: 0};
  int currentLevel = 0;
}
