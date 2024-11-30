import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/widgets/custom_buttons.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Courses Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'This is the Courses Page!',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ButtonPrimary(label: 'Back to Home', onPressed: () {
                Navigator.pop(context);
              })
          ],
        ),
      ),
    );
  }
}
