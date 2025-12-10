import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:moftahak/features/add%20child/add_child_view.dart';
import 'package:moftahak/features/add%20child/cubit/add_child_cubit.dart';
import 'package:moftahak/features/ai_logic/analysi_imageby_ai_screen.dart';
import 'package:moftahak/features/ai_logic/analysis_arg.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';
import 'package:moftahak/features/auth/login/login_view.dart';
import 'package:moftahak/features/auth/signup/sign_up_view.dart';
import 'package:moftahak/features/child%20analysis/cubit/all_drawings_cubit.dart';
import 'package:moftahak/features/child_details/child_details.dart';
import 'package:moftahak/features/child_details/cubit/child_details_cubit.dart';
import 'package:moftahak/features/drawing/cubit/add_drawing_cubit.dart';
import 'package:moftahak/features/drawing/drawing_screen.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';
import 'package:moftahak/features/main/main.dart';
import 'package:moftahak/features/onBoarding/on_boarding_view.dart';
import 'package:moftahak/features/settings/settings_view.dart';
import 'package:moftahak/features/splash/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/features/splash/cubit/splash_cubit.dart';
import 'package:moftahak/features/support/support_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => SplashCubit(),
          child: const SplashView(),
        );
      },
    ),

    GoRoute(path: '/onBoarding', builder: (context, state) => OnBoardingView()),

    GoRoute(path: '/home', builder: (context, state) => const Main()),

    GoRoute(path: '/login', builder: (context, state) => LoginView()),
    GoRoute(path: '/signUp', builder: (context, state) => SignUpView()),
    GoRoute(
      path: '/addChild',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => AddChildCubit(),
          child: const AddChildView(), // شاشة UI اللي انت عاملها
        );
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
            BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
          ],
          child: const SettingsView(),
        );
      },
    ),

    GoRoute(path: '/support', builder: (context, state) => SupportView()),
    GoRoute(
      path: '/drawing',
      builder: (context, state) => const DrawingScreen(),
    ),

    GoRoute(
      path: '/childDetails/:id',
      builder: (context, state) {
        final childId = state.pathParameters['id']!;

        return BlocProvider(
          create: (_) => ChildDetailsCubit()..loadChild(childId),
          child: const ChildDetailsView(),
        );
      },
    ),
    // GoRoute(
    //   path: '/allDrawings',
    //   builder: (context, state) => const ChildAnalysisScreen(),
    // ),
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
            BlocProvider<AddChildCubit>(create: (_) => AddChildCubit()),
            BlocProvider<AllDrawingsCubit>(
              create: (_) => AllDrawingsCubit(
                FirebaseFirestore.instance,
                FirebaseAuth.instance,
              ),
            ),
          ],
          child: const Main(),
        );
      },
    ),
    GoRoute(
      path: '/analysisDrawing',
      builder: (context, state) {
        // ناخذ الـ args اللي مررناها من DisplayImageScreen
        final args = state.extra as AnalysisArgs;

        return BlocProvider(
          create: (_) => AddDrawingCubit(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          ),
          child: AnalysiImagebyAiScreen(
            imageBytes: args.imageBytes,
            imageFilePath: args.imageFilePath,
            childId: args.childId,
          ),
        );
      },
    ),
  ],
);
