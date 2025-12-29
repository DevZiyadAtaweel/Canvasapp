import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:moftahak/features/add%20child/add_child_view.dart';
import 'package:moftahak/features/ai_logic/analysi_imageby_ai_screen.dart';
import 'package:moftahak/features/ai_logic/analysis_arg.dart';
import 'package:moftahak/features/ai_logic/display_image.dart';
import 'package:moftahak/features/auth/login/login_view.dart';
import 'package:moftahak/features/auth/signup/sign_up_view.dart';
import 'package:moftahak/features/chaild%20analysis%20details/child_analysis_details.dart';
import 'package:moftahak/features/child%20analysis/model/all_drawings_model.dart';
import 'package:moftahak/features/child_details/child_details.dart';
import 'package:moftahak/features/child_details/cubit/child_details_cubit.dart';
import 'package:moftahak/features/drawing/cubit/add_drawing_cubit.dart';
import 'package:moftahak/features/drawing/drawing_screen.dart';
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

    GoRoute(
      path: '/main',
      builder: (context, state) {
        final index = state.extra as int? ?? 0;
        return Main(initialIndex: index);
      },
    ),

    GoRoute(path: '/home', redirect: (context, state) => '/main'),

    GoRoute(path: '/login', builder: (context, state) => LoginView()),
    GoRoute(path: '/signUp', builder: (context, state) => SignUpView()),

    GoRoute(
      path: '/addChild',
      builder: (context, state) => const AddChildView(),
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(),
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

    GoRoute(
      path: '/analysisDrawing',
      builder: (context, state) {
        final args = state.extra as AnalysisArgs;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AddDrawingCubit(
                FirebaseFirestore.instance,
                FirebaseAuth.instance,
              ),
            ),
            BlocProvider(create: (_) => ChildDetailsCubit()),
          ],
          child: AnalysiImagebyAiScreen(
            imageBytes: args.imageBytes,
            imageFilePath: args.imageFilePath,
            childId: args.childId,
            child: args.child,
          ),
        );
      },
    ),

    GoRoute(
      path: '/displayImage',
      builder: (context, state) {
        final args = state.extra as AnalysisArgs;
        return DisplayImageScreen(
          imageBytes: args.imageBytes,
          imageFilePath: args.imageFilePath,
          childId: args.childId,
          child: args.child,
        );
      },
    ),

    GoRoute(
      path: '/drawingDetails',
      builder: (context, state) {
        final drawing = state.extra as AllDrawingsModel;
        return ChildAnalysisDetails(drawing: drawing);
      },
    ),
  ],
);
