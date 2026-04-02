import 'package:flutter/material.dart';
import 'package:note_app/services/auth_service.dart';
import '../models/user.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authService = AuthService();

  final List<User> users = [
    User(username: "admin", password: "123"),
    User(username: "user1", password: "111"),
  ];

  bool isValidUser(String username, String password) {
    return users.any(
      (user) => user.username == username && user.password == password,
    );
  }

  void handleLogin(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (isValidUser(username, password)) {
      await authService.login(username); //

      context.go('/home');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sai tài khoản hoặc mật khẩu")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleLogin(context),
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
