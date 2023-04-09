/*
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_updater/flutter_updater.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auto Update Demo',
      home: AutoUpdateScreen(),
    );
  }
}

class AutoUpdateScreen extends StatefulWidget {
  @override
  _AutoUpdateScreenState createState() => _AutoUpdateScreenState();
}

class _AutoUpdateScreenState extends State<AutoUpdateScreen> {
  // Create an instance of the Updater class
  Updater updater = Updater(
    updateUrl: 'https://yourdomain.com/update', // URL to your backend service
    androidId: 'com.yourcompany.yourapp', // Android package name of your app
    iosId: '1234567890', // iOS App Store ID of your app
  );

  @override
  void initState() {
    super.initState();
    // Call the checkForUpdate method when the screen is loaded
    updater.checkForUpdate().then((status) {
      if (status == UpdateStatus.available) {
        // Show a dialog to the user indicating that an update is available
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New version available'),
              content: Text('A new version of the app is available. Do you want to download and install it now?'),
              actions: [
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Download'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    downloadUpdate();
                  },
                ),
              ],
            );
          },
        );
      } else if (status == UpdateStatus.error) {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while checking for updates.'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Navigate to the home screen of your app if no updates are available
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void downloadUpdate() {
    if (Platform.isAndroid) {
      // For Android, download the updated APK file and call the installApk method to install it
      updater.downloadUpdate().then((value) {
        updater.installApk();
      });
    } else if (Platform.isIOS) {
      // For iOS, open the App Store page for your app to allow the user to download the update
      updater.openAppStore();
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Auto Update Demo'),
      ),
      body: Center(
        child: Text('Welcome to the home screen'),
      ),
    );
  }
}
*/
