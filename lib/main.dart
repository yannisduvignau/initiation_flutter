import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/template/login_page.dart';
import 'package:flutter_application_bachelor/template/register_page.dart';
import 'package:flutter_application_bachelor/template/home_page.dart';
import 'package:flutter_application_bachelor/template/themes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default theme color
  Color _currentThemeColor = const Color(0xFF003f88);

  // Function to change the theme color
  void _changeThemeColor(Color newColor) {
    setState(() {
      _currentThemeColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: _currentThemeColor, // Apply the current theme color
        colorScheme: ColorScheme.fromSeed(seedColor: _currentThemeColor),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => MyHomePage(
              title: 'Flutter App Project',
              onThemeChange: _changeThemeColor,
              currentThemeColor: _currentThemeColor,
            ),
        '/theme': (context) => ThemeChangerPage(
              currentThemeColor: _currentThemeColor,
              onThemeChange: _changeThemeColor,
            ),
      },
    );
  }
}
