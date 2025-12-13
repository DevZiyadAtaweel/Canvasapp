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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                drawing.drawingUrl,
                height: 290,
                width: double.infinity,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.textField,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'التقييم الأولي:',
                      style: AppTextStyles.almarai700style20.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      drawing.emotion ?? 'غير متوفر',
                      style: AppTextStyles.almarai700style20.copyWith(
                        height: 1.4,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.textField,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تقرير مفصّل:',
                      style: AppTextStyles.almarai700style20.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      drawing.description ?? 'غير متوفر',
                      style: AppTextStyles.almarai700style20.copyWith(
                        height: 1.4,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
