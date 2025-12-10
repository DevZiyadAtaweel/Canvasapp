import 'package:flutter/material.dart';
import 'package:moftahak/core/constants/app_colors.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/features/child%20analysis/model/all_drawings_model.dart';

class ChildAnalysisDetails extends StatelessWidget {
  const ChildAnalysisDetails({super.key, required this.drawing});
  final AllDrawingsModel drawing; // هذا اللي بنستقبله

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تفاصيل الرسمة')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Card(
            //TODO change the color
            //  color: Color(0xFFe6dcf5),
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      drawing.drawingUrl,
                      height: 290,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'التقييم الأولي:',
                    style: AppTextStyles.almarai700style20.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    drawing.emotion ?? 'غير متوفر',
                    style: AppTextStyles.almarai700style20.copyWith(
                      height: 1.4,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'تقرير مفصّل:',
                    style: AppTextStyles.almarai700style20.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    drawing.description ?? 'غير متوفر',
                    style: AppTextStyles.almarai700style20.copyWith(
                      height: 1.4,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
