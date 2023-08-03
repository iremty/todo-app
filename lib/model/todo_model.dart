import 'dart:convert';

import 'package:grock/grock.dart';

class ToDoModel {
  String? id;
  String? todo;
  bool? done;
  ToDoModel({
    this.id,
    this.todo,
    this.done,
  });
  ToDoModel copyWith({
    String? id,
    String? todo,
    bool? done,
  }) {
    return ToDoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "todo": todo,
      "done": done,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map["id"] != null ? map["id"] as String : null,
      todo: map["todo"] != null ? map["todo"] as String : null,
      done: map["done"] != null ? map["done"] as bool : null,
    );
  }
  String toJson() => json.encode(toMap());
  factory ToDoModel.fromJson(String source) =>
      ToDoModel.fromMap(json.decode(source));
  @override
  bool operator ==(covariant ToDoModel other) {
    if (identical(this, other)) return true;
    return
       other.id == id &&
       other.todo == todo &&
       other.done == done;
  }

  @override
  int get hashCode => id.hashCode ^ todo.hashCode ^ done.hashCode;
}
