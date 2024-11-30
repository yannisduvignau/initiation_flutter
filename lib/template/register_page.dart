import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/service/user_service.dart';
import 'package:flutter_application_bachelor/widgets/custom_buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserService _userService = UserService();

  void _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Perform registration
    if (username!='' && password!='') {
      await _userService.registerUser(username, password);

      // Check if the widget is still mounted before using context
      if (!mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );

      // Navigate back to the login page
      Navigator.pop(context);
    }else{
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insertion failed')),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Register', style: TextStyle(fontSize: 25),)
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username',icon: Icon(Icons.person)),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password',icon: Icon(Icons.password_outlined)),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ButtonPrimary(label: 'Register', onPressed: _register)
          ],
        ),
      ),
    );
  }
}
