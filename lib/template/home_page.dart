import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/template/contact_page.dart';
import 'package:flutter_application_bachelor/template/login_page.dart';
import 'package:flutter_application_bachelor/widgets/custom_buttons.dart';
import 'courses_page.dart'; // Importation de la page des cours
import 'categories_page.dart'; // Importation de la page des catégories
import 'themes_page.dart'; // Importation de la page pour changer de thème
import 'articles_page.dart'; // Importation de la page des articles

class MyHomePage extends StatefulWidget {
  const MyHomePage({
      super.key,
      required this.title,
      required this.currentThemeColor,
      required this.onThemeChange,
    });

  final String title;
  final Color currentThemeColor;
  final void Function(Color) onThemeChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Navigation vers les différentes pages
  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Montre le dialogue de déconnexion
  Future<void> _showLogoutDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _navigateToPage(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Use updated theme color
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Ensuring that DrawerHeader takes full width
            Container(
              width: double.infinity,  // Ensures the header takes the full width of the drawer
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: widget.currentThemeColor, // Use updated theme color
                ),
                child: const Text(
                  'Navigation Menu',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book_rounded),
              title: const Text('Courses'),
              onTap: () => _navigateToPage(const CoursesPage()),
            ),
            ListTile(
              leading: const Icon(Icons.category_rounded),
              title: const Text('Categories'),
              onTap: () => _navigateToPage(const CategoriesPage()),
            ),
            ListTile(
              leading: const Icon(Icons.article_rounded),
              title: const Text('Articles'),
              onTap: () => _navigateToPage(const ArticlesPage()),
            ),
            ListTile(
              leading: const Icon(Icons.list_outlined),
              title: const Text('TODO list'),
              onTap: () => '', // Handle navigation to To-Do List Page if necessary
            ),
            ListTile(
              leading: const Icon(Icons.color_lens_rounded),
              title: const Text('Theme changer'),
              onTap: () => _navigateToPage(ThemeChangerPage(
                  currentThemeColor: widget.currentThemeColor,
                  onThemeChange: widget.onThemeChange, // Pass the color change function
                ),
              ),
            ),
            const Spacer(),  // This will push the "Contact me" button to the bottom
            // "Contact me" button at the bottom
            ListTile(
              leading: const Icon(Icons.contact_emergency_rounded),
              title: const Text('Contact me'),
              onTap: () => _navigateToPage(const ContactPage()),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Welcome to my Application!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My application provides a variety of features to help you with your learning journey. You can explore courses, read articles, check out categories, and much more.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Key Features:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Courses: Access a wide range of courses to enhance your skills.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- Categories: Browse content based on your interests.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- Articles: Stay updated with the latest articles and news.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- Theme Changer: Personalize the app with different themes.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- To-Do List: Organize your tasks and goals in one place.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Feel free to explore and enjoy all the features that My app has to offer!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            Center(
              child: ButtonPrimary(
                label: 'Contact Us',
                onPressed: () {
                  _navigateToPage(const ContactPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
