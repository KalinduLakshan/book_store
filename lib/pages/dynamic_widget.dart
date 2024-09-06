import 'dart:async';
import 'package:book_store/navigation_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DynamicWidget extends StatefulWidget {
  const DynamicWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  // To control the scrolling position
  final ScrollController _scrollController = ScrollController();

  // Timer to move the tiles
  late Timer _timer;

  // Speed of scroll (pixels per tick)
  double scrollSpeed = 2;

  // Flag to detect if the user is scrolling
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();

    // Setting up a timer to move the list continuously
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients && !_isUserScrolling) {
        // Automatically scroll the ListView horizontally
        _scrollController.jumpTo(_scrollController.offset + scrollSpeed);

        // Reset scroll position to start when reaching the end
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        }
      }
    });

    // Listener to detect if the user is scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value) {
        _isUserScrolling = true;
      } else {
        _isUserScrolling = false;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 1,
          ),
          SizedBox(
            height: 65, // Height for the tiles
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                // Detect if the user is scrolling and prevent automatic scroll during user interaction
                if (notification.direction == ScrollDirection.idle) {
                  _isUserScrolling = false;
                } else {
                  _isUserScrolling = true;
                }
                return true;
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: 9, // Number of tiles
                itemBuilder: (context, index) {
                  // Define categories and icons for each tile
                  final categories = [
                    'Academic',
                    'Biography',
                    'Romance',
                    'Thriller',
                    'Science Fiction',
                    'Literary Fiction',
                    'Children',
                    'Historical Fiction',
                    'Mystery',
                  ];
                  final icons = [
                    Icons.school, // Academic
                    Icons.person, // Biography
                    Icons.favorite, // Romance
                    Icons.local_fire_department, // Thriller
                    Icons.science, // Science Fiction
                    Icons.menu_book, // Literary Fiction
                    Icons.child_friendly, // Children
                    Icons.history_edu, // Historical Fiction
                    Icons.search, // Mystery
                  ];

                  return GestureDetector(
                    onTap: () {
                      navigateToPage(context, index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 131, 10, 1),
                        ),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Make the box fit the content
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index], // Set the icon for each tile
                            color: const Color.fromARGB(255, 131, 10, 1),
                            size: 24,
                          ),
                          const SizedBox(
                              width: 8), // Spacing between icon and text
                          Text(
                            categories[index], // Set the name for each tile
                            style: const TextStyle(
                              color: Color.fromARGB(255, 131, 10, 1),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: const Center(
        child: Text(
          'You clicked a tile!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
