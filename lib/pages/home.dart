import 'package:book_store/pages/dynamic_widget.dart';
import 'package:book_store/pages/logout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Store",
          style: TextStyle(
            fontFamily: 'Cursive',
            fontSize: 30,
            color: Color.fromARGB(255, 131, 10, 1),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              size: 30,
              color: Color.fromARGB(255, 131, 10, 1),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 131, 10, 1),
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/head.png',
                      height: 50,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Title(
                  color: Colors.white,
                  child: const Column(
                    children: [
                      Text(
                        'Kalindu Lakshan',
                        style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'kalindu123@gmail.com',
                        style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    LogoutDialog.showExitDialog(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              title: const Text(
                'Item 1',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Item 2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Item 1',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Item 2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Item 1',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Item 2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 300,
            ),
            const Center(
              child: BottomAppBar(
                color: Color.fromARGB(255, 131, 10, 1),
                child: Column(
                  children: [
                    Text(
                      'Powered by',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Kali Book Creators',
                      style: TextStyle(
                        fontFamily: 'cursive',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Top Categories',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Times New Roman',
                color: Color.fromARGB(255, 131, 10, 1),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: DynamicWidget(),
          ),
          SizedBox(
            height: 20,
          ), // StatefulWidget for dynamic content
        ],
      ),
    );
  }
}
