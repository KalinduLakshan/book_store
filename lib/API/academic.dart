import 'package:flutter/material.dart';
import 'package:googleapis/books/v1.dart' as booksApi;
import 'package:http/http.dart' as http;
import 'package:book_store/Network Error/loading_error.dart';

class AcademicPage extends StatefulWidget {
  AcademicPage(BuildContext context);

  @override
  _AcademicPageState createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  List<booksApi.Volume> books = [];
  bool isGridView = true;
  bool hasError = false; // Track if there is an error
  String errorMessage = ''; // Store the error message

  @override
  void initState() {
    super.initState();
    fetchAcademicBooks();
  }

  Future<void> fetchAcademicBooks() async {
    var client = http.Client();

    try {
      var booksApiService = booksApi.BooksApi(client);
      var result = await booksApiService.volumes.list('academic');

      setState(() {
        books = result.items ?? [];
        hasError = false; // Reset error state if books are loaded
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Books'),
        actions: [
          if (!hasError) // Only show view toggle if there is no error
            IconButton(
              icon: Icon(
                isGridView ? Icons.list : Icons.grid_view,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isGridView = !isGridView;
                });
              },
            ),
        ],
      ),
      body: hasError
          ? LoadingError(
              errorMessage: errorMessage) // Show error widget if error occurs
          : books.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : isGridView
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.7,
                      ),
                      padding: const EdgeInsets.all(10),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        final title = book.volumeInfo?.title ?? 'No Title';
                        final authors = book.volumeInfo?.authors?.join(', ') ??
                            'No authors';
                        final thumbnail =
                            book.volumeInfo?.imageLinks?.thumbnail;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsPage(
                                  title: title,
                                  authors: authors,
                                  thumbnail: thumbnail,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: thumbnail != null
                                        ? Image.network(
                                            thumbnail,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )
                                        : const Icon(Icons.book, size: 100),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(15)),
                                    color: Colors.white,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookDetailsPage(
                                            title: title,
                                            authors: authors,
                                            thumbnail: thumbnail,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'See More',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        final title = book.volumeInfo?.title ?? 'No Title';
                        final authors = book.volumeInfo?.authors?.join(', ') ??
                            'No authors';
                        final thumbnail =
                            book.volumeInfo?.imageLinks?.thumbnail;

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          leading: thumbnail != null
                              ? Image.network(thumbnail, width: 50)
                              : const Icon(Icons.book, size: 50),
                          title: Text(title),
                          subtitle: Text('Authors: $authors'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsPage(
                                  title: title,
                                  authors: authors,
                                  thumbnail: thumbnail,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  final String title;
  final String authors;
  final String? thumbnail;

  const BookDetailsPage({
    Key? key,
    required this.title,
    required this.authors,
    this.thumbnail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (thumbnail != null)
              Image.network(thumbnail!)
            else
              const Icon(Icons.book, size: 150),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Authors: $authors',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
