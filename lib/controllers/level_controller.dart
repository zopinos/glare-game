/*
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class LevelController {
  final storage = Hive.box("storage");

  RxSet<int> completedLevels;
  RxMap<int, int> levelScores;

  LevelController() : completedLevels = <int>{}.obs {
    if (storage.get('completedLevels') == null) {
      storage.put('completedLevels', <int>{});
    }

    completedLevels.value = storage
        .get('completedLevels')
        .map(
          (task) => Task.fromJson(task),
        )
        .toList();
  }

  void _save() {
    storage.put(
      'tasks',
      tasks.map((task) => task.toJson()).toList(),
    );
  }

  void add(Task task) {
    tasks.add(task);
    _save();
  }

  void changeCompleted(Task task) {
    task.completed = !task.completed;
    tasks.refresh();
    _save();
  }

  void delete(Task task) {
    tasks.remove(task);
    tasks.refresh();
    _save();
  }

  get size => tasks.length;
}
*/
