import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String avatarUrl =
        'https://api.dicebear.com/9.x/adventurer/svg?seed=';

    // Sample list of avatar seeds (you can add more or allow users to input their own)
    final List<String> avatarSeeds = ['Tigger', 'Kali', 'Simba', 'Leo'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Avatar'),
        backgroundColor: const Color.fromARGB(255, 131, 10, 1),
      ),
      body: ListView.builder(
        itemCount: avatarSeeds.length,
        itemBuilder: (context, index) {
          final seed = avatarSeeds[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(
                '$avatarUrl$seed',
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                  ); // Display this if there's an error loading the image
                },
              ),
              title: Text(seed),
              onTap: () {
                // Perform action on avatar selection (e.g., save the selected avatar)
                Navigator.pop(context, '$avatarUrl$seed');
              },
            ),
          );
        },
      ),
    );
  }
}
