import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/app_assets.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_strings.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/splash/cubit/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // أول ما تفتح الشاشة، نطلب من الكيوبت يشيّك
    context.read<SplashCubit>().checkAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.splash,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.35)),

          // BlocListener عشان نسمع للتغييرات وننقل الشاشات
          BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              customNavigate(context, '/onBoarding');

              // if (state is SplashToOnBoarding) {
              // customNavigate(context, '/onBoarding');
              // }
              // } else if (state is SplashToAuth) {
              //   customNavigate(context, '/login');
              // } else if (state is SplashToHome) {
              //   customNavigate(context, '/home');
              // }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.appName,
                    style: AppTextStyles.lato600style20.copyWith(
                      fontSize: 40,
                      color: Colors.white,
                      letterSpacing: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    AppStrings.welcomeMessage,
                    style: AppTextStyles.lato600style20.copyWith(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
