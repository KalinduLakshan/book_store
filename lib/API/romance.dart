import 'package:book_store/Network%20Error/loading_error.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:googleapis/books/v1.dart' as booksApi;
import 'package:http/http.dart' as http;

class RomancePage extends StatefulWidget {
  RomancePage(BuildContext context);

  @override
  _RomancePageState createState() => _RomancePageState();
}

class _RomancePageState extends State<RomancePage> {
  List<booksApi.Volume> books = [];
  bool isGridView = true; // Default view mode is grid view
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchAcademicBooks();
  }

  Future<void> fetchAcademicBooks() async {
    // Instantiate an HTTP client
    var client = http.Client();

    try {
      // Initialize the Google Books API client
      var booksApiService = booksApi.BooksApi(client);

      // Make the request to fetch academic books using a query
      var result = await booksApiService.volumes.list('romance novels');

      // Update the state with the fetched books
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
        title: const Text('Romance books'),
        actions: [
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
                        crossAxisCount: 2, // 2 columns
                        mainAxisSpacing: 20, // Spacing between rows
                        crossAxisSpacing: 20, // Spacing between columns
                        childAspectRatio:
                            0.7, // Adjusted to better fit image and button
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
                            // Navigate to details page when the container is tapped
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
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1), // Shadow color
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
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
                                      bottom: Radius.circular(15),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigate to details page when "See More" is pressed
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
                                      backgroundColor: Colors
                                          .white, // Button background color
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      'See More',
                                      style: TextStyle(
                                        color:
                                            Colors.black, // Button text color
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
                              : const Icon(
                                  Icons.book,
                                  size: 50,
                                ),
                          title: Text(title),
                          subtitle: Text('Authors: $authors'),
                          onTap: () {
                            // Navigate to details page when the list item is tapped
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
