class SubTask {
  String title;
  String id;
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
