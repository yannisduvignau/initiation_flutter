import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/widgets/custom_buttons.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Categories Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'This is the Categories Page!',
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
