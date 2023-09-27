class TaskModel {
  static const String collectionName = "tasks";
  String? id;
  String? title;
  String? description;
  bool? isDone;
  DateTime? dateTime;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isDone,
    this.dateTime,
  });

  TaskModel.FromFirestore(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            isDone: json["isDone"],
            dateTime: DateTime.fromMillisecondsSinceEpoch(json["dateTime"]));

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}
