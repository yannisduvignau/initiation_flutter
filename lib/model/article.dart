class Article {
  final int id;
  final String title;
  final String description;

  const Article({
    required this.id,
    required this.title,
    required this.description,
  });

  // Convertir un Article en Map pour l'insertion dans la DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Convertir un Map en Article
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}