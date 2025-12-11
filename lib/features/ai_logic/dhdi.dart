import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

import 'package:moftahak/features/drawing/cubit/add_drawing_cubit.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/custem_elevatedButton_widgets.dart'; // مكتبة فك تشفير JSON
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// ... باقي الاستيرادات

class AnalysiImagebyAiScreen extends StatefulWidget {
  final Uint8List imageBytes;
  final String imageFilePath;
  final String childId;

  const AnalysiImagebyAiScreen({
    super.key,
    required this.imageBytes,
    required this.imageFilePath,
    required this.childId,
  });

  @override
  State<AnalysiImagebyAiScreen> createState() => _AnalysiImagebyAiScreenState();
}

class _AnalysiImagebyAiScreenState extends State<AnalysiImagebyAiScreen> {
  Map<String, dynamic>? _analysis;
  bool _isLoading = false;
  String? _rawText;

  // 🔥 تحسين: استخدام المتغيرات الخاصة (التي تبدأ بـ _)
  // لتمييزها كمتغيرات داخلية للحالة (State)

  @override
  void initState() {
    super.initState();
    _analyzeChildEmotion();
  }

  Future<void> _analyzeChildEmotion() async {
    setState(() {
      _isLoading = true;
      _analysis = null;
      _rawText = null;
    });

    // 🔥 تحسين: استخدام final أو const بدلاً من التكرار
    final apiKey = dotenv.env['API_KEY'] ?? '';
    final model = GenerativeModel(model: "gemini-2.5-flash", apiKey: apiKey);

    //     final  promptText =("""
    //     أنت خبير نفسي مُعتمد ومتخصص حصراً في العلاج بالفن واضطراب ما بعد الصدمة (PTSD) لدى الأطفال.
    //
    // **المهمة:**
    // قم بالتحليل السريري للرسم المرفق. يجب أن يكون الإخراج تحليلًا فنيًا **موجزًا للغاية** يركز فقط على الدلالات التي تشير مباشرة إلى الصدمة أو القلق المزمن أو الفقدان العميق. تجنب أي إطالة أو تفسيرات غير ضرورية.
    //
    // **معايير التحليل:**
    // 1.  **التركيز الصارم:** استخدم فقط المؤشرات الفنية الواضحة: استخدام الألوان السوداء/الداكنة، ضغط القلم الشديد، حجم الشكل (صغير جداً)، ووجود رموز للتهديد أو العزلة (مثل الأشكال المسجونة).
    // 2.  **الإيجاز:** يجب أن تكون كل نقطة في القوائم عبارة عن جملة واحدة أو عبارة مختصرة جداً.
    //
    // **المخرجات المطلوبة (بصيغة JSON حصراً وباللغة العربية الفصحى):**
    //
    // {
    //   "التقييم_الأولي": "تحديد الاتجاه السريري العام في كلمة أو كلمتين (مثال: 'صدمة حادة'، 'قلق مزمن'، 'ثبات').",
    //   "مؤشرات_الصدمة": ["اذكر المؤشرات الفنية الأكثر أهمية (1-2 نقطة فقط)."],
    //   "الاضطرابات_المحتملة": ["حدد التشخيص المحتمل أو المشاعر الأساسية (مثال: PTSD، اكتئاب)."],
    //   "تدخل_عاجل": "الإجابة يجب أن تكون 'نعم' أو 'لا' فقط."
    // }
    //
    // """);

    // Prompt المُحسَّن الذي يطلب إخراج JSON باللغة العربية
    const promptText = ("""
   أنت خبير نفسي مُعتمد ومتخصص في العلاج بالفن وتحليل رسومات الأطفال.

    **المهمة:**
    قم بتحليل الرسم المرفق. يجب أن يُركز تقييمك النفسي الفني على استخلاص الدلالات المتعلقة بالصدمة، القلق، ومشاعر الفقد أو التهديد بناءً على المؤشرات الفنية (كالألوان الداكنة، ضغط القلم، وحجم العناصر).

    **المخرجات المطلوبة (بصيغة JSON حصراً وباللغة العربية الفصحى):**
    يجب أن يكون الإخراج في قالب JSON التالي تماماً، لا تضف أي نص قبل أو بعد الأقواس {}.

    {
      "التقييم_الأولي_المهني": "ملخص شامل في جملة واحدة.",
      "المؤشرات_الفنية_المرصودة": ["حدد 3 إلى 5 مؤشرات فنية تم تحليلها."],
      "الاضطرابات_المحتملة": ["حدد الاضطرابات التي قد يشير إليها الرسم (مثال: القلق العام، اضطراب ما بعد الصدمة)."],
      "تنبيه_الحاجة_للتدخل_العاجل": "الإجابة يجب أن تكون 'نعم' أو 'لا' فقط."
    }
""");
    final prompt = TextPart(promptText);

    try {
      final response = await model.generateContent([
        Content.multi([prompt, DataPart("image/jpeg", widget.imageBytes)]),
      ]);

      _rawText = response.text;
      _analysis = _extractJson(_rawText!);
    } catch (e) {
      _rawText = "خطأ: فشل الاتصال بالخادم أو مشكلة في مفتاح API: $e";
    }

    setState(() => _isLoading = false);
  }

  // 🔥 تحسين: تمكين الدالة من أن تكون 'خاصة' (Private) باستخدام (_)
  Map<String, dynamic>? _extractJson(String text) {
    // تحديد بداية ونهاية كتلة JSON
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');

    if (start == -1 || end == -1) {
      return null;
    }

    final jsonString = text.substring(start, end + 1);

    try {
      // فك تشفير JSON باستخدام دالة jsonDecode الآمنة والموثوقة
      final Map<String, dynamic> data = jsonDecode(jsonString);

      // 🔥 تحسين: التحقق من القوائم قبل الانضمام إليها
      final List Indicators = (data["المؤشرات_الفنية_المرصودة"] as List?) ?? [];
      final List Disturbances = (data["الاضطرابات_المحتملة"] as List?) ?? [];
      final String alert = data["تنبيه_الحاجة_للتدخل_العاجل"] ?? "غير متوفر";

      // دمج المؤشرات والاضطرابات في نص واحد منظم لعرضه في خانة "وصف الحالة"
      String descriptionReport =
          "**المؤشرات الفنية المرصودة:**\n- ${Indicators.join('\n- ')}\n\n"
          "**الاضطرابات المحتملة:**\n- ${Disturbances.join('\n- ')}\n\n"
          "**تنبيه الحاجة لتدخل عاجل:** $alert";

      // إرجاع خريطة النتائج باستخدام المفاتيح التي تحتاجها واجهة المستخدم
      return {
        // نستخدم المفتاح "emotion" لعرض "التقييم_الأولي_المهني"
        "emotion": data["التقييم_الأولي_المهني"] ?? "غير متوفر",

        // نستخدم المفتاح "description" لعرض التقرير المفصل المنسق
        "description": descriptionReport,
      };
    } catch (e) {
      debugPrint(
        "JSON Decoding Error: $e",
      ); // استخدام debugPrint أفضل في Flutter
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // نحول مسار الصورة إلى File عشان نبعته للكيوبت
    final drawingFile = File(widget.imageFilePath);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
          children:[ Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("تحليل الصورة"),
              centerTitle: true,
              elevation: 0,
            ),

            // 👈 هنا ربطنا الشاشة مع AddDrawingCubit
            body: BlocConsumer<AddDrawingCubit, AddDrawingState>(
              listener: (context, state) {
                if (state is AddDrawingSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ الرسمة بنجاح ✅')),
                  );
                } else if (state is AddDrawingFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                final isSaving = state is AddDrawingLoading;

                return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 7),

                          // عرض الصورة
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.memory(
                              widget.imageBytes,
                              height: 320,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),


                          // زر "بدء التحليل" (AI فقط)

                          const SizedBox(height: 12),

                          // 🔥 زر حفظ الرسمة في Supabase + Firestore عبر الكيوبت
                          if (_analysis != null) // الشرط الجديد هنا
                            SizedBox(
                              width: double.infinity,
                              // استخدام الكلاس المخصص بدلاً من ElevatedButton
                              child: CustemElevatedbuttonWidgets(
                                textButton: "حفظ الرسمة", // النص المطلوب عرضه
                                width: double.infinity, // لنقل قيمة العرض إلى الـ Widget المخصص
                                isLoading: isSaving,    // تمرير حالة التحميل isSaving
                                onPressed: isSaving
                                    ? null
                                    : () {
                                  context.read<AddDrawingCubit>().addDrawing(
                                    drawingFile: drawingFile,
                                    childId: widget.childId,
                                    analysis: _analysis,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('جارٍ حفظ الرسمة...'),
                                    ),
                                  );
                                },
                                // تم إزالة خصائص style و child المكررة لأنها أصبحت داخل الكلاس المخصص
                              ),
                            ),

                          const SizedBox(height: 20),

                          // عرض النتائج المُنظمة من الـ AI
                          if (_analysis != null) ...[
                            _buildResultCard(
                              "التقييم الأولي المهني",
                              _analysis!["emotion"],
                              maxLines: 5,
                            ),
                            _buildResultCard(
                              "تقرير التحليل المفصّل",
                              _analysis!["description"],
                              maxLines: 50,
                            ),
                          ],

                          // عرض النص الخام عند الخطأ
                          if (!_isLoading && _analysis == null && _rawText != null)
                            Text(
                              "حدث خطأ في قراءة JSON أو API. النص الخام:\n$_rawText",
                              style: const TextStyle(color: Colors.redAccent),
                              textDirection: TextDirection.rtl,
                            ),
                        ]
                    )
                );
              },
            ),
          ),
          ]
      ),
    );
  }

  // 🟢 دالة _buildResultCard
  Widget _buildResultCard(String title, String? value, {int maxLines = 4}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 6),
          Text(
            value ?? "غير متوفر",
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
            maxLines: maxLines,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}

// 🔥 تحسين: تبسيط الدالة لتكون أكثر نظافة
Future<Uint8List?> pickImage({required ImageSource source}) async {
  final picker = ImagePicker();
  final XFile? file = await await picker.pickImage(source: source);
  return file?.readAsBytes(); // استخدام Safe Call (?. )
}

