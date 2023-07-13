class Book {
  String? uid;
  final String title;
  final String author;
  final String description;
  final bool isAvailable;

  Book({
     this.uid,
    required this.title,
    required this.author,
    required this.description,
    required this.isAvailable,
  });
}