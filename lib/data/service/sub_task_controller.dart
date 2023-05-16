import 'package:flutter/material.dart';
import 'package:flutter_todos_website/ID/locator.dart';
import 'package:flutter_todos_website/data/api/end_point.dart';
import 'package:flutter_todos_website/data/api/subnote_api.dart';
import 'package:flutter_todos_website/data/model/subNote.dart';

class SubTaskController extends ChangeNotifier {
  List<SubTask> subTaskList = [];
  SubNoteAPI subNoteAPI = getIt<SubNoteAPI>();

  void setSubTaskList(List<SubTask> subTaskList) {
    //  this.subTaskList.clear();
    this.subTaskList = subTaskList;
    notifyListeners();
  }

  List<SubTask> get getSubTaskList => subTaskList;

  void addSubNote(
      {required String user_id,
      required String note_id,
      required String title,
      required String completedAt,
      required String createdAt,
      required bool isCancelled,
      required bool isDone}) async {
    final response = await subNoteAPI.addSubNote(
        path: Endpoint.addSubNote,
        user_id: user_id,
        note_id: note_id,
        title: title,
        completedAt: completedAt,
        createdAt: createdAt,
        isCancelled: isCancelled,
        isDone: isDone);

    if (response.statusCode == 200) {
      subTaskList.add(SubTask.fromJson(response.data['data']));
      notifyListeners();
    }
  }

  void UpdateSubNote(
      {required String user_id,
      required String note_id,
      required String subNote_id,
      required String title,
      required String completedAt,
      required String createdAt,
      required bool isCancelled,
      required bool isDone}) async {
    final response = await subNoteAPI.updateSubNote(
        path: Endpoint.updateSubNote,
        user_id: user_id,
        note_id: note_id,
        subNote_id: subNote_id,
        title: title,
        completedAt: completedAt,
        createdAt: createdAt,
        isCancelled: isCancelled,
        isDone: isDone);

    if (response.statusCode == 200) {
      final t = subTaskList.firstWhere((element) => element.id == subNote_id);
      t.title = title;
      t.isCancelled = isCancelled;
      t.isDone = isDone;
      t.completedAt = completedAt;
      subTaskList[subTaskList.indexOf(t)] = t;
      notifyListeners();
    }
  }

  void deleteSubNote({
    required String user_id,
    required String note_id,
    required String subNote_id,
  }) async {
    final response = await subNoteAPI.deleteSubNote(
        path: Endpoint.deleteSubNote,
        user_id: user_id,
        note_id: note_id,
        subNote_id: subNote_id);
    if (response.statusCode == 200) {
      final t = subTaskList.firstWhere((element) => element.id == subNote_id);
      subTaskList.remove(t);
      notifyListeners();
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    final element = subTaskList.removeAt(oldIndex);
    subTaskList.insert(newIndex, element);
    notifyListeners();
  }

  void sortOnCreatedDate() {
    subTaskList.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
    notifyListeners();
  }

  void sortOnCompletedDate() {
    // => a.completedAt?.compareTo(b.completedAt ?? "") ?? 1
    subTaskList.sort((a, b) {
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

  void checkDone(
      {required SubTask item,
      required String user_id,
      required String note_id,
      value}) {
    item.isDone = value!;
    if (item.isDone!) {
      item.completedAt = DateTime.now().toString();
    } else {
      item.completedAt = "";
    }
    UpdateSubNote(
        completedAt: item.completedAt ?? "",
        createdAt: item.createdAt,
        title: item.title,
        isCancelled: item.isCancelled ?? false,
        isDone: item.isDone ?? false,
        subNote_id: item.id,
        user_id: user_id,
        note_id: note_id);
    notifyListeners();
  }

  void cancelOn(SubTask item, String user_id, String note_id) {
    item.isCancelled = !item.isCancelled!;
    item.isDone = item.isDone == true ? false : null;
    item.completedAt = null;
    print("  the cancelled  value is : ${item.isCancelled}");
    UpdateSubNote(
        completedAt: item.completedAt ?? "",
        createdAt: item.createdAt,
        title: item.title,
        isCancelled: item.isCancelled ?? false,
        isDone: item.isDone ?? false,
        subNote_id: item.id,
        user_id: user_id,
        note_id: note_id);

    notifyListeners();
    //
  }
}
