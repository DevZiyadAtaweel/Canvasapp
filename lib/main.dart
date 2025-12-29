import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/routes/app_routes.dart';
import 'package:moftahak/features/add%20child/cubit/add_child_cubit.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';
import 'package:moftahak/features/child%20analysis/cubit/all_drawings_cubit.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';
import 'package:moftahak/firebase_options.dart';

// استيراد شاشة البداية لتشغيل التطبيق بشكل مؤقت
// افتراض مسار الشاشة الرئيسية
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://sroqjsnknejpmddoblfj.supabase.co',
    anonKey: dotenv.env['SUPABASE_ANNON_KEY'] ?? '',
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit()..startUserListener(),
        ),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<AddChildCubit>(create: (_) => AddChildCubit()),
        BlocProvider<AllDrawingsCubit>(
          create: (_) => AllDrawingsCubit(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,

          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: AppTextStyles.almarai700style20.copyWith(
            color: AppColors.primaryColor,
            fontSize: 24,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        dialogBackgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
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
