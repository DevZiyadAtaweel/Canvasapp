import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_assets.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_strings.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/constants/navigation.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              customNavigatePop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.supportTitle,
                    style: AppTextStyles.almarai700style28,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    AppStrings.supportEmail,
                    style: AppTextStyles.almarai700style20.copyWith(
                      color: AppColors.kPrimaryPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    AppStrings.socialMedia,
                    style: AppTextStyles.almarai700style28,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.facebookIcon),
                      SizedBox(width: 20.0),
                      Image.asset(AppAssets.twitterIcon),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
