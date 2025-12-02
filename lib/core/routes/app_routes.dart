import 'package:go_router/go_router.dart';
import 'package:moftahak/features/add%20son/add_child_view.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';
import 'package:moftahak/features/auth/login/login_view.dart';
import 'package:moftahak/features/auth/signup/sign_up_view.dart';
import 'package:moftahak/features/drawing/drawing_screen.dart';
import 'package:moftahak/features/home/cubit/home_cubit.dart';
import 'package:moftahak/features/home/home_screen.dart';
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
      path: '/home',
      builder: (context, state) => BlocProvider(
        create: (_) => HomeCubit()..startUserListener(),
        child: const HomeScreen(),
      ),
    ),
    GoRoute(path: '/login', builder: (context, state) => LoginView()),
    GoRoute(path: '/signUp', builder: (context, state) => SignUpView()),
    GoRoute(path: '/addChild', builder: (context, state) => AddChildView()),
    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit()..startUserListener(),
            ),
          ],
          child: const SettingsView(),
        );
      },
    ),
    GoRoute(path: '/support', builder: (context, state) => SupportView()),
    GoRoute(path: '/drawing', builder: (context, state) => DrawingScreen()),
  ],
);
