import 'package:flutter/material.dart';
import 'package:flutter_application_bachelor/service/article_service.dart';
import 'package:flutter_application_bachelor/widgets/custom_buttons.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final ArticleService _articleService = ArticleService();

  List<Map<String, dynamic>> articles = [];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _loadArticles();
  }

  void _loadArticles() async {
    final allArticles = await _articleService.getArticles();
    setState(() {
      articles = allArticles;
    });
  }

  Future<void> _addArticlesFromJson(List<Map<String, dynamic>> jsonArticles) async {
    for (final article in jsonArticles) {
      await _addArticle(article); // Add each article from the JSON
    }
  }

  void _addArticlesFromJsonDemo() {
    const jsonArticles = [
      {'title': 'Flutter Basics', 'description': 'Learn the basics of Flutter.'},
      {'title': 'State Management', 'description': 'Explore state management techniques.'},
      {'title': 'Dart Language', 'description': 'Understand Dart programming.'},
      {'title': 'Building UI', 'description': 'Design responsive user interfaces.'},
      {'title': 'Flutter Widgets', 'description': 'Dive deep into Flutter widgets.'},
    ];
    
    _addArticlesFromJson(jsonArticles);
  }

  Future<void> _addArticle(Map<String, dynamic> article) async {
    final success = await _articleService.insertArticle(article);

    if (success != 0) {
      _loadArticles(); // Reload articles after insertion
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add article')),
      );
    }
  }

  Future<void> _deleteArticle(int id) async {
    final success = await _articleService.deleteArticle(id);

    if (success!=0) {
      _loadArticles(); // Reload articles after deletion
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete article')),
      );
    }
  }

  Future<void> _editArticle(int id, String newTitle, String newDescription) async {
    final updatedArticle = {
      'id': id,
      'title': newTitle,
      'description': newDescription,
    };

    final success = await _articleService.updateArticle(updatedArticle);

    if (success) {
      _loadArticles(); // Reload articles after updating
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to edit article')),
      );
    }
  }

  void _showEditArticleDialog(Map<String, dynamic> article) {
    final isEdit = article['id'] != null;
    _titleController.text = article['title'] ?? '';
    _descriptionController.text = article['description'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Article' : 'Add Article'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (isEdit) {
                  _editArticle(
                    article['id'],
                    _titleController.text,
                    _descriptionController.text,
                  );
                } else {
                  _addArticle({
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                  });
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeletionPopup(Map<String, dynamic> article) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Article'),
          content: Text("Are you sure you want to delete article '${article['title']}'?"),
          actions: [
            ButtonSecondary(label: 'Cancel', onPressed: () => Navigator.of(context).pop(false)),
            ButtonPrimary(label: 'Delete', onPressed: () {
                _deleteArticle(article['id']); // Confirm deletion
                Navigator.of(context).pop(true); // Close dialog
              })
          ],
        );
      },
    );

    if (result ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Article "${article['title']}" deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Articles Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _titleController.clear();
              _descriptionController.clear();
              _showEditArticleDialog({'id': null, 'title': '', 'description': ''});
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _addArticlesFromJsonDemo, // Load JSON demo articles
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          Future.delayed(Duration(milliseconds: index * 100), () {
            _animationController.forward();
          });

          return SlideTransition(
            position: _slideAnimation,
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(article['title'] ?? 'No Title', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(article['description'] ?? 'No Description'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditArticleDialog(article),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeletionPopup(article),
                    ),
                  ],
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked on "${article['title']}"')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}


