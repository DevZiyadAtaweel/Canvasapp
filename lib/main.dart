import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moftahak/firebase_options.dart';
// يجب عليك استيراد AppRouter و HomeScreen يدوياً إذا لم يكونا موجودين في الملف الأصلي
// يجب استبدال السطرين التاليين بالاستيراد الصحيح لمشروعك:
// import 'package:moftahak/core/router/app_router.dart'; // افترضت مسار AppRouter
// import 'package:moftahak/features/home/home_screen.dart'; // افترضت مسار HomeScreen

// ملاحظة: بما أن التعارض لم يوضح مكان تعريف 'appRouter' أو 'HomeScreen'،
// سأفترض أن 'HomeScreen' هو للتجربة و 'appRouter' هو التوجيه الفعلي.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // تأكد من أن DefaultFirebaseOptions متوفرة في ملف firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}






















































// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:moftahak/firebase_options.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: HomeScreen(),
//         return MaterialApp.router(
//     routerConfig: appRouter,
//     debugShowCheckedModeBanner: false,
//
//     theme: ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: Colors.white),
//     bodyMedium: TextStyle(color: Colors.white),
//     bodySmall: TextStyle(color: Colors.white),
//     titleLarge: TextStyle(color: Colors.white),
//     titleMedium: TextStyle(color: Colors.white),
//     titleSmall: TextStyle(color: Colors.white),
//     labelLarge: TextStyle(color: Colors.white),
//     labelMedium: TextStyle(color: Colors.white),
//     labelSmall: TextStyle(color: Colors.white),
//     ),
//     )
//     ,
//     )
//     ,
//
//     );
//   }
//   }
