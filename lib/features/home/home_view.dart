import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_gradients.dart';
import 'package:moftahak/core/constants/navigation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppGradients.mainGradient),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              customNavigatePush(context, "/addChild");
            },
            child: const Text("Go to Add Child"),
          ),
        ),
      ),
    );
  }
}
