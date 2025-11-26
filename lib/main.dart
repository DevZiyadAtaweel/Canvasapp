import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moftahak/firebase_options.dart';
import 'package:moftahak/view/screen/drawing_screen.dart';
import 'package:moftahak/view/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
    // MaterialApp.router(
    //   routerConfig: appRouter,
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    // );
  }
}
