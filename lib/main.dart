import 'package:credicxo_task/screens/bookmarks.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(CredicxoTask());
}

class CredicxoTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(), // Trending tracks list.
        'BookmarksPage': (context) => BookmarksPage(),
      },
    );
  }
}
