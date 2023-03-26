import 'package:flutter/material.dart';

import '../model/task.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];

  void setTasks(List<Task> tasks) {
    this.tasks = tasks;
    //  notifyListeners();
  }

  List<Task> getTasks() {
    return tasks;
  }

  Task getTask(int index) {
    Task task = tasks[index];
    notifyListeners();
    return task;
  }

  double getTaskprogress(int index) {
    double progress = 0;
    List<SubTask> subTaskList = tasks[index].subTaskList;
    if (subTaskList.isNotEmpty) {
      List isDoneTasks =
          subTaskList.where((task) => task.isDone as bool).toList();
      progress = isDoneTasks.length / subTaskList.length;
      // notifyListeners();
    }

    return progress;
  }
}
