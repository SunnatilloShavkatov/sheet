// ignore_for_file: discarded_futures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheet/route.dart';

class Book {
  const Book(this.title, this.author);

  final String title;
  final String author;
}

class BooksApp extends StatefulWidget {
  const BooksApp({super.key});

  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  Book? _selectedBook;

  List<Book> books = <Book>[
    const Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    const Book('Foundation', 'Isaac Asimov'),
    const Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: brightness == Brightness.light ? ThemeData.light() : ThemeData.dark(),
    title: 'Books App',
    builder:
        (BuildContext context, Widget? child) =>
            CupertinoTheme(data: CupertinoThemeData(brightness: brightness), child: child!),
    home: Navigator(
      pages: <Page<dynamic>>[
        MaterialPage<bool>(
          key: const ValueKey<String>('BooksListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
            onBrigthnessChanged: (Brightness brightness) {
              setState(() {
                this.brightness = brightness;
              });
            },
          ),
        ),
        if (_selectedBook != null)
          SheetPage<void>(
            key: ValueKey<Book?>(_selectedBook),
            child: BookDetailsScreen(book: _selectedBook!),
            barrierColor: Colors.black26,
          ),
      ],
      onDidRemovePage: (_) {},
    ),
  );

  void _handleBookTapped(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }
}

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key, required this.books, required this.onTapped, required this.onBrigthnessChanged});

  final List<Book> books;
  final ValueChanged<Book> onTapped;
  final void Function(Brightness) onBrigthnessChanged;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        middle: const Text('Book'),
        trailing: IconButton(
          icon: Icon(brightness == Brightness.light ? Icons.nightlight_round : Icons.wb_sunny),
          onPressed: () {
            onBrigthnessChanged(brightness == Brightness.light ? Brightness.dark : Brightness.light);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            for (final Book book in books)
              ListTile(title: Text(book.title), subtitle: Text(book.author), onTap: () => onTapped(book)),
          ],
        ),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CupertinoNavigationBar(middle: Text('Book')),
    body: Padding(
      padding: const EdgeInsets.all(8) + const EdgeInsets.only(top: 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(book.title, style: Theme.of(context).textTheme.titleLarge),
          Text(book.author, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Invalid'))),
          ),
        );
      },
    ),
  );
}
