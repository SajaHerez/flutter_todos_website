import 'subNote.dart';

class Task {
  String title;
  String id;
  List<SubTask> subTaskList;
  String createdAt;
  String? completedAt;
  bool? isDone;
  bool? isCancelled;
  Task({
    required this.title,
    required this.id,
    required this.subTaskList,
    required this.createdAt,
    this.completedAt,
    this.isDone = false,
    this.isCancelled = false,
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    final list = json["SubTaskList"] as List;
   List<SubTask> sublist= list.map((subtask) => SubTask.fromJson(subtask)).toList();
    return Task(
        title: json["title"],
        id: json["id"],
        createdAt: json["createdAt"],
        completedAt: json["completedAt"],
        isDone: json["isDone"],
        isCancelled: json["isCancelled"],
        subTaskList: sublist );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "subTaskList": subTaskList,
      "createdAt": createdAt,
      "completedAt": completedAt,
      "isDone": isDone,
      "isCancelled": isCancelled
    };
  }
}
