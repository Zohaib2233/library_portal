import '../models/books_model.dart';
import '../models/library_model.dart';

final Book book1 = Book(
  title: 'Book 1',
  author: 'Author 1',
  description: 'This is the description for Book 1',
  isAvailable: true,
);

final Book book2 = Book(
  title: 'Book 2',
  author: 'Author 2',
  description: 'This is the description for Book 2',
  isAvailable: false,
);

final Book book3 = Book(
  title: 'Book 3',
  author: 'Author 3',
  description: 'This is the description for Book 3',
  isAvailable: true,
);

final List<Book> dummyBooks = [book1, book2, book3];

final Library dummyLibrary = Library(books: dummyBooks);