import 'package:flutter/material.dart';
import 'package:player/provider/playlist_provider.dart';
import 'package:player/provider/theme_provider.dart';
import 'package:player/screens/test.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlaylistProvider(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyApp(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
