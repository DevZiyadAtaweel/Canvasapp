import 'package:go_router/go_router.dart';
import 'package:moftahak/features/auth/login/login_view.dart';
import 'package:moftahak/features/auth/signup/sign_up_view.dart';
import 'package:moftahak/features/home/home_view.dart';
import 'package:moftahak/features/onBoarding/on_boarding_view.dart';
import 'package:moftahak/features/splash/splash_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: '/onBoarding', builder: (context, state) => OnBoardingView()),

    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    GoRoute(path: '/signUp', builder: (context, state) => const SignUpView()),
  ],
);
