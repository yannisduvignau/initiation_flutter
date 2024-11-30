import 'package:flutter/material.dart';

class ThemeChangerPage extends StatefulWidget {
  const ThemeChangerPage({
    super.key,
    required this.currentThemeColor,
    required this.onThemeChange,
  });

  final Color currentThemeColor;
  final void Function(Color) onThemeChange;

  @override
  State<ThemeChangerPage> createState() => _ThemeChangerPageState();
}

class _ThemeChangerPageState extends State<ThemeChangerPage> {
  Color _currentColor = const Color(0xFF003f88);

  /// Incrémente le compteur
  void _updateThemeLocalColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Color> availableColors = [
      const Color(0xFF003f88),
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
      Colors.cyan,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Theme'),
        backgroundColor: _currentColor, // Use current theme color
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: availableColors.map((color) {
          return GestureDetector(
            onTap: () {
              // Immediately apply the selected color to the theme
              widget.onThemeChange(color); // This will call the parent function
              _updateThemeLocalColor(color);
            },
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: color == _currentColor
                      ? Colors.black
                      : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
