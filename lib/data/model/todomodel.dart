class TodoModel {
  final int id;
  final String title;
  final String description;
  bool completed;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
