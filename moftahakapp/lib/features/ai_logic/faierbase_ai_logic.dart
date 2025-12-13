import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LogicAi extends StatefulWidget {
  const LogicAi({super.key});

  @override
  State<LogicAi> createState() => _LogicAiState();
}

class _LogicAiState extends State<LogicAi> {
  // 1. تعريف جميع متغيرات الحالة
  final ImagePicker _picker = ImagePicker();
  final GenerativeModel _geminiModel = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  List<XFile>? _mediaFileList;
  dynamic _pickImageError;
  String? _retrieveDataError;
  String _generatedTextResult = '';
  bool _isLoading = false;

  void _onGenerateButtonPressed() async {
    if (_mediaFileList == null || _mediaFileList!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار صورة أولاً.')),
      );
      return;
    }

    final selectedImage = _mediaFileList!.first;
    const myPrompt = '';
    setState(() {
      _isLoading = true;
      _generatedTextResult = 'جاري تحليل الصورة...';
    });

    final generatedText = await generateContentFromImage(
      imageFile: selectedImage,
      textPrompt: myPrompt,
      model: _geminiModel,
    );

    setState(() {
      _isLoading = false;
      _generatedTextResult = generatedText;
    });
  }

  // 3. دالة build (نظيفة ومرتبة)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (AppBar هنا)
      body: Padding(
        padding: const EdgeInsets.all(16.0), // يمكنك ضبط الهامش حسب الحاجة
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // لتمديد الأزرار
          children: <Widget>[
            // ... (هنا توضع أزرار التقاط وإرفاق الصورة)

            // زر جديد لاستدعاء دالة الذكاء الاصطناعي
            ElevatedButton(
              onPressed: _isLoading ? null : _onGenerateButtonPressed,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('أرسل الصورة للتحليل'),
            ),

            const SizedBox(height: 20),

            // لعرض نتيجة الذكاء الاصطناعي
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _generatedTextResult.isEmpty
                    ? 'النتيجة ستظهر هنا.'
                    : _generatedTextResult,
                style: const TextStyle(fontSize: 18),
              ),
            ),

            // ... (باقي تصميم الواجهة، مثل قائمة الإرشادات)
          ],
        ),
      ),
    );
  }

  Future generateContentFromImage({
    required XFile imageFile,
    required String textPrompt,
    required GenerativeModel model,
  }) async {}
}
