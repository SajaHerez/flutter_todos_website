import 'package:flutter/material.dart';
import 'package:flutter_todos_website/ID/locator.dart';
import 'package:flutter_todos_website/data/api/end_point.dart';
import 'package:flutter_todos_website/data/api/note_api.dart';

import '../model/note.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  NoteAPI noteAPI = getIt<NoteAPI>();

  void setTasks(List<Task> tasks) {
    this.tasks = tasks;
    notifyListeners();
  }

  Future<void> getNotes({required String user_id}) async {
    final response =
        await noteAPI.getNote(path: Endpoint.notes, user_id: user_id);
    if (response.statusCode == 200) {
      tasks.clear();
      final jsonList = response.data["task_list"] as List;
      List<Task> taskList = jsonList.map((x) => Task.fromJson(x)).toList();
      setTasks(taskList);
    }
  }

  void addNote(
      {required String user_id,
      required String title,
      required String completedAt,
      required String createdAt,
      required bool isCancelled,
      required bool isDone}) async {
    final response = await noteAPI.createNote(
        path: Endpoint.createNote,
        userId: user_id,
        title: title,
        completedAt: completedAt,
        createdAt: createdAt,
        isCancelled: isCancelled,
        isDone: isDone);
    if (response.statusCode == 200) {
      tasks.add(Task.fromJson(response.data["data"]));
      notifyListeners();
    }
  }

  void updateNote(
      {required String user_id,
      required String note_id,
      required String title,
      required String completedAt,
      required String createdAt,
      required bool isCancelled,
      required bool isDone}) async {
    final response = await noteAPI.updateNote(
        path: Endpoint.updateNote,
        title: title,
        createdAt: createdAt,
        completedAt: completedAt,
        isCancelled: isCancelled,
        isDone: isDone,
        user_id: user_id,
        note_id: note_id);
    if (response.statusCode == 200) {
      final t = tasks.firstWhere((element) => element.id == note_id);
      t.title = title;
      tasks[tasks.indexOf(t)] = t;
      notifyListeners();
    }
  }

  void deleteNote({
    required String user_id,
    required String note_id,
  }) async {
    final response = await noteAPI.deleteNote(
        path: Endpoint.deleteNote, user_id: user_id, note_id: note_id);
    if (response.statusCode == 200) {
      final t = tasks.firstWhere((element) => element.id == note_id);
      tasks.remove(t);
      notifyListeners();
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    final element = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, element);
    notifyListeners();
  }

  void sortOnCreatedDate() {
    tasks.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
    notifyListeners();
  }

  void sortOnCompletedDate() {
    // => a.completedAt?.compareTo(b.completedAt ?? "") ?? 1
    tasks.sort((a, b) {
      if (a.completedAt!.isEmpty) {
        return 1;
      }
      if (b.completedAt!.isEmpty) {
        return -1;
      }
      // Compare the dates and return the result
      return a.completedAt!.compareTo(b.completedAt!);
    });
    notifyListeners();
  }

  void checkDone(Task item, String user_id, value) {
    item.isDone = value!;
    if (item.isDone!) {
      item.completedAt = DateTime.now().toString();
    }
    updateNote(
        completedAt: item.completedAt ?? "",
        createdAt: item.createdAt,
        title: item.title,
        isCancelled: item.isCancelled ?? false,
        isDone: item.isDone ?? false,
        note_id: item.id,
        user_id: user_id);
    notifyListeners();
  }

  void cancelOn(
    Task item,
    String user_id,
  ) {
    item.isCancelled = !item.isCancelled!;
    item.isDone = item.isDone == true ? false : null;
    item.completedAt = null;
    print("  the cancelled  value is : ${item.isCancelled}");
    updateNote(
        completedAt: item.completedAt ?? "",
        createdAt: item.createdAt,
        title: item.title,
        isCancelled: item.isCancelled ?? false,
        isDone: item.isDone ?? false,
        note_id: item.id,
        user_id: user_id);

    notifyListeners();
    // 3 cases  active => normal style , cancel => red style , done=> green style
  }

//   List<Task> tasks = [];
//   Map<int, double> tasksProgressList = {};
//   double todayProgress = 0;

//   List<Task> getTasks() {
//     return tasks;
//   }

//   setTaskprogress(int id) {
//     print("in side setTaskprogress ");
//     Task task = tasks.firstWhere((element) => element.id == id);
//     print(task);
//     List<SubTask> subTaskList = task.subTaskList;
//     if (subTaskList.isNotEmpty) {
//       List isDoneTasks =
//           subTaskList.where((task) => task.isDone as bool).toList();
//       tasksProgressList[id] = isDoneTasks.length / subTaskList.length;
//       print(' tasksProgress  ${tasksProgressList[id]}');
//       notifyListeners();
//     }
//   }

//   double? getTaskprogress(int id) {
//     return tasksProgressList[id];
//   }

//   setTodayProgress() {
//     print("inside setTodayProgress >>>>>> ");
//     List<Task> todayTasks = tasks
//         .where((task) =>
//             task.createdAt.substring(0, 11) ==
//             DateTime.now().toString().substring(0, 11))
//         .toList();
//     print(
//         "The time for today =====   ${DateTime.now().toString().substring(0, 11)}");
//     print(todayTasks);
//     double sum = 0;
//     todayTasks.forEach((task) {
//       sum += getTaskprogress(task.id) ?? 0;
//       print("sum of setTodayProgress $sum");
//     });
//     todayProgress = sum / todayTasks.length;
//     print("todayProgress of setTodayProgress $todayProgress");
//     notifyListeners();
//   }

//   getTodayProgress() {
//     return todayProgress;
//   }
}
