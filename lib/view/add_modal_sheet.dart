import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/firebase_auth_provider.dart';
import 'package:todo_app/provider/firebase_storage_provider.dart';

class AddModalSheet extends ConsumerStatefulWidget {
  const AddModalSheet({super.key});

  @override
  ConsumerState<AddModalSheet> createState() => _AddModalSheetState();
}

class _AddModalSheetState extends ConsumerState<AddModalSheet> {
  final textController = TextEditingController();
  late final FocusNode node;
  void addTodo()async{
    if(textController.text.trim().isEmpty) return;
    final id =ref.read(currentUserProvider)!.uid;
    final model=ToDoModel(
      id:id,
      todo: textController.text.trim(),done:false);
    ref.read(addTodoProvider(model)).then((value){
      ref.refresh(getToDoProvider);
      Grock.back();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    node = FocusNode();
    node.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.padding,
      margin: 16.padding,
      decoration:BoxDecoration(color: Colors.white,borderRadius: 12.borderRadius) ,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            focusNode: node,
            decoration: InputDecoration(hintText: "Todo Giriniz..."),
          ),
          12.height,
          ElevatedButton(onPressed:()=>addTodo() , child: Text("Ekle"))
        ],
      ),
    );
  }
}
