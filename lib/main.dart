import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moftahak/core/routes/app_routes.dart';
import 'package:moftahak/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
