import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_assets.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_strings.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final PageController pageController = PageController();

  final List<String> images = [
    AppAssets.onBoarding1,
    AppAssets.onBoarding2,
    AppAssets.onBoarding3,
  ];

  final List<String> titles = ["MOFTAHAK", "MOFTAHAK", "MOFTAHAK"];

  final List<String> descriptions = [
    AppStrings.onBoarding1,
    AppStrings.onBoarding2,
    AppStrings.onBoarding3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -61,
            left: -44,
            child: Container(
              width: 122,
              height: 164,
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                ),
              ),
            ),
          ),

          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(images[index]),
                      const SizedBox(height: 30),

                      Text(
                        titles[index],
                        style: AppTextStyles.pacifico400style40.copyWith(
                          fontSize: 30,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          descriptions[index],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.lato600style20.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: WormEffect(
                  dotColor: Colors.white,
                  activeDotColor: AppColors.green,
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  onTap: () {
                    int current = pageController.page!.round();
                    if (current < 2) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      customNavigate(context, "/login");
                    }
                  },
                  child: Container(
                    height: 48,
                    width: 400,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "التالي",
                      style: AppTextStyles.lato600style20.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => customNavigate(context, "/login"),
                child: Text(
                  "تخطي",
                  style: AppTextStyles.lato600style20.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
