import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/firebase_auth_provider.dart';

final getToDoProvider = FutureProvider((ref) async {
  final userId = ref.read(currentUserProvider)!.uid;
  final getData = await FirebaseFirestore.instance
      .collection("todos")
      .where("id", isEqualTo: userId)
      .get();

  final List<ToDoModel> result =
      getData.docs.map((e) => ToDoModel.fromMap(e.data())).toList();
  return result;
});

final addTodoProvider =
    Provider.autoDispose.family((ref, ToDoModel model) async {
  return await FirebaseFirestore.instance
      .collection("todos")
      .add(model.toMap());
});
