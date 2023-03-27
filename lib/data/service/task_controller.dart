import 'package:flutter/material.dart';

import '../model/task.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  Map<int, double> tasksProgressList = {};
  double todayProgress = 0;
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

  setTodayProgress() {
    print("inside setTodayProgress >>>>>> ");
    List<Task> todayTasks = tasks
        .where((task) =>
            task.createdAt.substring(0, 11) ==
            DateTime.now().toString().substring(0, 11))
        .toList();
    print(
        "The time for today =====   ${DateTime.now().toString().substring(0, 11)}");
    print(todayTasks);
    double sum = 0;
    todayTasks.forEach((task) {
      sum += getTaskprogress(task.id) ?? 0;
      print("sum of setTodayProgress $sum");
    });
    todayProgress = sum / todayTasks.length;
    print("todayProgress of setTodayProgress $todayProgress");
    notifyListeners();
  }

  getTodayProgress() {
    return todayProgress;
  }
}
