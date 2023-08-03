import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/firebase_auth_provider.dart';
import 'package:todo_app/provider/firebase_storage_provider.dart';
import 'package:todo_app/view/add_modal_sheet.dart';
import 'package:todo_app/view/splash_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          IconButton(
            onPressed: () => ref.read(signOutProvider).then((value) {
              ref.refresh(currentUserProvider);
              Grock.toRemove(const SplashView());
            }),
            icon: Icon(Icons.exit_to_app_rounded),
            tooltip: "Çıkış Yap",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor:Colors.transparent ,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddModalSheet(),
            )),
        child: Icon(Icons.add),
      ),
      body: ref.watch(getToDoProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = data.elementAt(index);
                  return Container(
                    padding: 16.verticalP,
                    color: index % 2 == 0 ? Colors.grey.shade200 : Colors.white,
                    width: double.infinity,
                    child: ListTile(
                      title: Text(item.todo ?? ""),
                      trailing: Checkbox(
                          value: item.done ?? false, onChanged: (newValue) {}),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Icon(
                Icons.warning,
                color: Colors.red,
              ),
            ),
          ),
    );
  }
}
