import 'package:flutter/material.dart';

import '../model/task.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  Map<int, double> tasksProgressList = {};

  void setTasks(List<Task> tasks) {
    this.tasks = tasks;
    //  notifyListeners();
  }

  List<Task> getTasks() {
    return tasks;
  }
  setTaskprogress(int id) {
    print("in side setTaskprogress ");
    Task task = tasks.firstWhere((element) => element.id == id);
    print(task);
    List<SubTask> subTaskList = task.subTaskList;
    if (subTaskList.isNotEmpty) {
      List isDoneTasks =
          subTaskList.where((task) => task.isDone as bool).toList();
      tasksProgressList[id] = isDoneTasks.length / subTaskList.length;
      print(' tasksProgress  ${tasksProgressList[id]}');
      notifyListeners();
    }
  }

  double? getTaskprogress(int id) {
    return tasksProgressList[id];
  }
}
