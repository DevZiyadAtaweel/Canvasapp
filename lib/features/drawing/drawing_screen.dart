import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moftahak/core/constants/app_text_styles.dart';
import 'package:moftahak/core/widgets/children_dropdown.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/custem_elevatedButton_widgets.dart';
import '../ai_logic/display_image.dart';
import '../home/cubit/home_cubit.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? selectedImage;

  // دالة مسؤولة عن التقاط أو اختيار الصورة
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(source: source);

      if (file == null) return;

      final bytes = await file.readAsBytes();

      setState(() {
        selectedImage = bytes;
      });

      // الانتقال لصفحة عرض الصورة
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DisplayImageScreen(imageBytes: selectedImage!),
        ),
      );
    } catch (e) {
      print("خطأ في اختيار الصورة: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('اختر فنان اليوم'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // نرجع خطوة للخلف بدل ما نعمل push لصفحة جديدة
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // حالة التحميل / البداية
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            // حالة الخطأ
            if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              );
            }

            // حالة النجاح
            if (state is HomeSuccess) {
              final homeCubit = context.read<HomeCubit>();

              // نفترض أن الـ UserModel فيه حقل name
              final firstName = homeCubit.getFirstName(state.user.name);
              // اختيار اسم الطفل المحدد إن وجد
              String? selectedChildName;
              for (final child in state.children) {
                if (child.id == state.selectedChildId) {
                  selectedChildName = child.name;
                  break;
                }
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: SizedBox(width: 100, child: ChildrenDropdown()),
                    ),
                    const SizedBox(height: 16),

                    // عرض اسم المستخدم
                    if (firstName.isNotEmpty)
                      Text(
                        'أهلًا، $firstName 👋',
                        style: AppTextStyles.almarai700style20,
                        textAlign: TextAlign.right,
                      ),

                    const SizedBox(height: 8),

                    // عرض اسم الطفل المختار إن وجد
                    if (selectedChildName != null)
                      Text(
                        'الفنان اليوم: $selectedChildName',
                        style: AppTextStyles.almarai700style20,

                        textAlign: TextAlign.right,
                      ),

                    const SizedBox(height: 50),

                    // أزرار اختيار الصورة

                    // صندوق التعليمات
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe6dcf5),
                        // لون البطاقة الأساسي أبيض (لكنها محاطة بظل بنفسجي)
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.kPrimaryPurple.withOpacity(0.22),
                            blurRadius: 20,
                            offset: const Offset(0, 1), // ظل سفلي
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.kPrimaryPurple.withOpacity(0.6),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // العنوان
                           Text(
                            'تأكد من الآتي قبل التقاط الصورة',
                            textAlign: TextAlign.center,
                            style:AppTextStyles.almarai700style20.copyWith(color: Colors.black)
                          ),

                          const SizedBox(height: 15),
                          Divider(
                            color: AppColors.kPrimaryDarkPurple,
                            height: 1,
                          ),
                          const SizedBox(height: 15),

                          // قائمة الخيارات (List Tiles)
                          TextContainer('تأكد من وضوح التصوير'),
                          TextContainer('تأكد من عدم وجود ظلال'),
                          TextContainer('تأكد من ثبات الكاميرا عند التصوير'),
                          TextContainer('تأكد من وضوح التصوير'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // const Divider(
                    //   color: Colors.black,
                    //   height: 40,
                    //   thickness: 1,
                    // ),
                    const SizedBox(height: 40),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustemElevatedbuttonWidgets(
                            onPressed: () => pickImage(ImageSource.gallery),
                            textButton: 'إرفاق صورة',
                            width: double.infinity,
                            // width: MediaQuery.of(context).size.width * 0.4,
                            icon: const Icon(Icons.upload, size: 22),
                          ),
                          SizedBox(height: 24),
                          CustemElevatedbuttonWidgets(
                            onPressed: () => pickImage(ImageSource.camera),
                            textButton: 'التقاط صورة',
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 22,
                            ),
                            width: double.infinity,

                            // width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '• $text',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  // Row(
  // mainAxisAlignment: MainAxisAlignment.end,
  // children: [
  // Text(
  // 'تأكد من وضوح التصوير',
  // style: TextStyle(
  // color: AppColors.kPrimaryPurple,
  // fontSize: 18
  // ),
  // ),
  // SizedBox(
  // width: 5,
  // ),
  // const Icon(
  // Icons.check_circle,
  // // color: Colors.purpleAccent,
  // color: Color(0xffa78bfa),
  // size: 18,
  // ),
  // ]
  // ),

  Widget TextContainer(String text) {
    // يمكنك تغيير الألوان هنا لتجنب الحاجة لملف AppColors إذا لم يكن مُستوردًا
    const Color primaryPurple = Color(0xffa78bfa);

    return Row(
      // لجعل النص والأيقونة تبدأ من اليمين
      mainAxisAlignment: MainAxisAlignment.end,

      // لضمان التعامل السليم مع النص العربي
      textDirection: TextDirection.ltr,

      children: [
        // 1. النص (في البداية من اليمين)
        Text(
          text, // استخدام المتغير المُمرر للدالة
          style:
          AppTextStyles.almarai500style16.copyWith( color: Colors.black.withOpacity(0.5),     fontWeight: FontWeight.w700,
          ) ,


    textDirection: TextDirection.rtl,
        ),

        // مسافة فاصلة صغيرة
        const SizedBox(width: 5),

        // 2. الأيقونة (تأتي بعد النص من اليمين)
        const Icon(Icons.check_circle, color: primaryPurple, size: 18),
      ],
    );
  }
}
