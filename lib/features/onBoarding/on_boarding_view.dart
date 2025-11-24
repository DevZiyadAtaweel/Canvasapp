import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_assets.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_strings.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController pageController = PageController();

  int currentPage = 0;

  final List<String> images = [
    AppAssets.onBoarding1,
    AppAssets.onBoarding2,
    AppAssets.onBoarding3,
  ];

  final List<String> descriptions = [
    AppStrings.onBoarding1,
    AppStrings.onBoarding2,
    AppStrings.onBoarding3,
  ];

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  Future<void> _setNotFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_open', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(images[currentPage], fit: BoxFit.cover),
          ),

          // طبقة شفافة فوق الصورة (اختياري عشان النص يبان أوضح)
          Container(color: Colors.black.withOpacity(0.1)),

          // المحتوى
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: currentPage == 2 ? 1 : 3),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          descriptions[index],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.lato700style28,
                        ),
                      ),
                      Spacer(flex: 3),

                      // (currentPage == 2)
                      //      Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //           horizontal: 30,
                      //         ),
                      //         child: Text(
                      //           descriptions[index],
                      //           textAlign: TextAlign.center,
                      //           style: AppTextStyles.lato700style28,
                      //         ),
                      //       )
                      //     : const SizedBox(height: 200),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 30),
                      //   child: Text(
                      //     descriptions[index],
                      //     textAlign: TextAlign.center,
                      //     style: AppTextStyles.lato700style28,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              SmoothPageIndicator(
                controller: pageController,
                count: images.length,

                effect: WormEffect(
                  dotColor: Colors.white.withOpacity(0.6),
                  activeDotColor: AppColors.green,
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  onTap: () async {
                    if (currentPage < images.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      await _setNotFirstOpen();
                      customNavigate(context, "/login");
                    }
                  },
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      currentPage == images.length - 1 ? "ابدأ" : "التالي",
                      style: AppTextStyles.lato600style20.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              if (currentPage < images.length - 1)
                TextButton(
                  onPressed: () async {
                    await _setNotFirstOpen();
                    customNavigate(context, "/login");
                  },
                  child: Text(
                    "تخطي",
                    style: AppTextStyles.lato600style20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              else
                const SizedBox(height: 48),

              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
