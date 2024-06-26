import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/video_provider.dart';
import 'package:video_app/screens/video_list_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => VideoProvider()..fetchVideos(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Video Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: VideoListScreen());
  }
}
