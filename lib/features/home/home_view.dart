import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:moftahak/features/auth/cubit/auth_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          // رجّعي المستخدم لصفحة تسجيل الدخول بعد تسجيل الخروج
          customNavigate(context, '/login');
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            child: const Text("تسجيل الخروج"),
          ),
        ),
      ),
    );
  }
}
