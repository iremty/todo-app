import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:todo_app/provider/firebase_auth_provider.dart';
import 'package:todo_app/view/home_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (!emailController.text.trim().isEmail) return;
    if (passwordController.text.trim().length < 4) return;
    final List<String> list = [
      emailController.text.trim(),
      passwordController.text.trim()
    ];
    ref
        .read(loginUserProvider(list))
        .then((value) => Grock.toRemove(HomeView()))
        .catchError((err) => Grock.toast(text: err.toString()));
  }

  void register() {
    if (!emailController.text.trim().isEmail) return;
    if (passwordController.text.trim().length < 4) return;
    final List<String> list = [
      emailController.text.trim(),
      passwordController.text.trim()
    ];
    ref
        .read(registerUserProvider(list))
        .then((value) => Grock.toRemove(HomeView()))
        .catchError((err) => Grock.toast(text: err.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "E-mail"),
                ),
                12.height,
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "Şifre"),
                ),
                48.height,
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: ()=>login(), child: Text("Giriş Yap"))),
                24.height,
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: ()=>register(), child: Text("Kayıt Yap")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
