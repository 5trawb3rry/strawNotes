import 'package:flutter/material.dart';
import 'package:strawnotes/core/constants.dart';
import 'package:strawnotes/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StrawNotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Cantarell',
        scaffoldBackgroundColor: background,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor: Colors.transparent,
          titleTextStyle: const TextStyle(
            color: primary,
            fontSize: 32,
            fontFamily: 'Fredoka',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}
