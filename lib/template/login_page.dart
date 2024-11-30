import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/service/user_service.dart';
import 'package:flutter_application_bachelor/widgets/custom_buttons.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserService _userService = UserService();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Perform login operation
    final success = await _userService.loginUser(username, password);

    // Check if the widget is still mounted
    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to the home page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }


  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Login', style: TextStyle(fontSize: 25),)
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username', icon: Icon(Icons.person)),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password', icon: Icon(Icons.password_outlined)),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ButtonPrimary(label: 'Login', onPressed: _login),
            ButtonSecondary(label: 'Register', onPressed: _navigateToRegister),
          ],
        ),
      ),
    );
  }
}
