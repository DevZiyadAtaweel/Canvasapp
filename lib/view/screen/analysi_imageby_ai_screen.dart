import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';

// شاشة تحليل الصورة بالذكاء الاصطناعي
class AnalysiImagebyAiScreen extends StatelessWidget {
  // استقبال ملف الصورة الملتقطة هنا
  //final XFile? imageFile;
  Uint8List? imageFile;

  Future<String> analyzeChildEmotion(Uint8List imageBytes) async {
    final apiKey = "AIzaSyCGO-IYBzaVIARV-o980oW46WFI7BiTPy8";

    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);
    //النص الخاص بالذكاء لارساله
    final content = [
      Content.multi([
        TextPart(
          "Analyze the emotional state of the child in this image. "
          "Return the result as JSON with fields {emotion, confidence, description}. "
          "Be accurate and consider facial expression, eyes, posture.",
        ),
        DataPart("image/jpeg", imageBytes),
      ]),
    ];

    final response = await model.generateContent(content);

    return response.text ?? "No response";
  }

  AnalysiImagebyAiScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    // التحقق من وجود ملف الصورة
    if (imageFile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('تحليل الصورة بالذكاء الاصطناعي')),
        body: const Center(child: Text('خطأ: لم يتم تمرير ملف صورة.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('تحليل الصورة بالذكاء الاصطناعي'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // لضمان محاذاة كل العناصر في منتصف الشاشة عمودياً
            mainAxisAlignment: MainAxisAlignment.start, // البدء من الأعلى
            children: [
              const Text(
                'تم استلام الصورة بنجاح!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // ** تعديل حجم الصورة **
              // SizedBox(
              //   height: 300, // الارتفاع الجديد (مثال)
              //   width: double.infinity, // العرض يملأ المساحة المتاحة أفقياً
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10.0),
              //     // لإضافة حواف دائرية
              //     child: Image.file(
              //       // التحقق من أن imageFile ليس null قبل استخدامه
              //
              //       // يضمن تغطية الصورة للمساحة المحددة (قد يقص جزءاً منها)
              //
              //
              // ),
              // // ** نهاية التعديل **
              const SizedBox(height: 30),
              // هذا هو المكان الذي ستبدأ فيه عملية التحليل
              const Text(
                'جاري إعداد الصورة للتحليل الفني...',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              // لإعطاء مساحة فارغة في الأسفل
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Uint8List?> pickImage({required ImageSource source}) async {
  final picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);

  if (file == null) return null;
  return await file.readAsBytes();
}

Future<String> analyzeChildEmotion(Uint8List imageBytes) async {
  final apiKey = "YOUR_GOOGLE_API_KEY";

  final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);

  final content = [
    Content.multi([
      TextPart(
        "Analyze the emotional state of the child in this image. "
        "Return the result as JSON with fields {emotion, confidence, description}. "
        "Be accurate and consider facial expression, eyes, posture.",
      ),
      DataPart("image/jpeg", imageBytes),
    ]),
  ];

  final response = await model.generateContent(content);

  return response.text ?? "No response";
}
