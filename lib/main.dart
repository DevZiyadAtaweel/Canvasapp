import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moftahak/core/routes/app_routes.dart';
import 'package:moftahak/firebase_options.dart';

// استيراد شاشة البداية لتشغيل التطبيق بشكل مؤقت
import 'package:moftahak/features/home/home_screen.dart'; // افتراض مسار الشاشة الرئيسية
import 'package:moftahak/view/screen/analysi_imageby_ai_screen.dart';

import 'features/ai_logic/faierbase_ai_logic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تم حل التعارض: تم اعتماد بنية MaterialApp.router مرة واحدة
    // مع دمج جميع إعدادات الـ Theme والـ routerConfig.
    return MaterialApp.router(
      // تأكد أن 'appRouter' معرف ومتوفر للاستخدام
      routerConfig: appRouter,

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
