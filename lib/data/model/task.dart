class Task {
  String title;
  int id;
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
    List<SubTask> sublist =
        json["subTaskList"].map((subtask) => SubTask.fromJson(subtask));
    return Task(
        title: json["title"],
        id: json["id"],
        createdAt: json["createdAt"],
        completedAt: json["completedAt"],
        isDone: json["isDone"],
        isCancelled: json["isCancelled"],
        subTaskList: sublist);
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

class SubTask {
  String title;
  int id;
  String createdAt;
  String? completedAt;
  bool? isDone;
  bool? isCancelled;
  SubTask({
    required this.title,
    required this.id,
    required this.createdAt,
    this.completedAt,
    this.isDone = false,
    this.isCancelled = false,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
        title: json["title"],
        id: json["id"],
        createdAt: json["createdAt"],
        completedAt: json["completedAt"],
        isDone: json["isDone"],
        isCancelled: json['isCancelled']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "createdAt": createdAt,
      "completedAt": completedAt,
      "isDone": isDone,
      "isCancelled":isCancelled
    };
  }
}
