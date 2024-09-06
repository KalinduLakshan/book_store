import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart'; // For launching network settings

class LoadingError extends StatelessWidget {
  final String errorMessage;

  const LoadingError({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The image is now clickable
          GestureDetector(
            onTap: () async {
              // Open the mobile network settings
              await LaunchApp.openApp(
                androidPackageName: 'com.android.settings', // For Android
                openStore: false,
              );
            },
            child: Image.asset(
              'assets/cartoon-cloud-without-network-hint.png',
              height: 330, // Adjusted height for better sizing
              width: 330, // Adjusted width for better sizing
              fit: BoxFit
                  .contain, // Ensures the image maintains its aspect ratio
            ),
          ),
          const SizedBox(height: 20),
          // Optional error message text below the image
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.redAccent,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
