import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this to use SystemNavigator.pop()

class LogoutDialog {
  static void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to exit?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog and stay
              },
              child: const Text(
                "Stay",
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 131, 10, 1), // Same color as tile text
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Exit the app completely
              },
              child: const Text(
                "Exit",
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 131, 10, 1), // Same color as tile text
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
