import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert'; // مكتبة فك تشفير JSON

class AnalysiImagebyAiScreen extends StatefulWidget {
  final Uint8List imageFile;

  const AnalysiImagebyAiScreen({super.key, required this.imageFile});

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
    const apiKey = "AIzaSyCGO-IYBzaVIARV-o980oW46WFI7BiTPy8";
    final model = GenerativeModel(
      model: "gemini-2.5-flash",
      apiKey: apiKey,
    );

    final promptText = TextPart("""
أنت خبير نفسي مُعتمد متخصص في العلاج بالفن وتحليل رسومات الأطفال المتعرضين لصدمات الحروب (PTSD). مهمتك هي تقديم تقييم فني سريري موجز.

**السياق:** تحليل رسم لطفل متضرر من النزاع في غزة.

**المهمة:** تحليل الصورة لتحديد الدلالات الفنية للصدمة، القلق، أو الفقدان، وتقديم التقييم بأقصى إيجاز ممكن.

**معايير التحليل:** اعتمد على الألوان الداكنة، ضغط القلم، حجم الأشكال، وموضوعات العدوان/الفقد أو العزلة (الأشكال المسجونة/بدون ملامح).

**المخرجات المطلوبة (بصيغة JSON حصراً وباللغة العربية الفصحى):**

يجب أن يكون الإخراج حصراً وفق الهيكل التالي وبأقل عدد ممكن من الكلمات:

{
  "الخلاصة_السريرية": "جملة واحدة تحدد الاتجاه العام للرسم (مثال: مؤشرات قوية لاضطراب القلق).",
  "المؤشرات_الفنية_الرئيسية": ["اذكر المؤشرات الفنية الأكثر أهمية فقط (1-3 نقاط)."],
  "الاضطرابات_المحتملة": ["حدد الاضطراب المحتمل أو المشاعر الرئيسية (مثال: PTSD، اكتئاب، خوف من الانفصال)."],
  "توصية_التدخل_العاجل": "الإجابة يجب أن تكون 'نعم' أو 'لا' فقط."
}
""");

    // Prompt المُحسَّن الذي يطلب إخراج JSON باللغة العربية
//     const promptText = ("""
// أنت خبير نفسي مُعتمد ومتخصص في العلاج بالفن وتحليل رسومات الأطفال، ولديك خبرة عميقة في تشخيص اضطرابات ما بعد الصدمة (PTSD) واضطرابات القلق الناجمة عن التعرض للنزاعات والحروب.
//
// **السياق:**
// أنت بصدد تحليل رسم لطفل متضرر من الأحداث في قطاع غزة، ويجب أن يكون تحليلك مهنياً وموجهاً لدعم الأخصائيين النفسيين.
//
// **المهمة:**
// قم بتحليل الصورة المرفقة. يجب أن يُركز تقييمك النفسي الفني على استخلاص الدلالات المتعلقة بالصدمة، القلق، ومشاعر الفقد أو التهديد.
//
// **معايير التحليل الأساسية (ركز عليها جيداً):**
// 1.  **الألوان المستخدمة:** (مثل: سيادة الألوان الباردة/الداكنة، غياب الألوان الزاهية، الاستخدام المكثف للأحمر أو الأسود، التلوين العشوائي أو الخروج عن الحدود).
// 2.  **التكوين والتنظيم المكاني:** (مثل: الحجم الصغير جدًا للشخصيات، وضع الأشكال في زاوية واحدة، ازدحام العناصر، رسم خط أرضي مُهدد أو غير مستقر).
// 3.  **المحتوى الرمزي:** (مثل: رسم رموز العدوان/القصف، غياب الأشكال البشرية المهمة (الأهل)، رسم وجوه بدون ملامح أو عيون، رسم أشكال مغلقة أو مسجونة، تكرار الأشكال الحادة أو التخريب).
// 4.  **خطوط الرسم والضغط:** (مثل: الخطوط المتقطعة التي تعبر عن التردد أو القلق، الضغط الشديد على القلم الذي يعبر عن التوتر والغضب المكبوت، أو الخطوط الخفيفة جدًا).
//
// **المخرجات المطلوبة (بصيغة JSON حصراً):**
// يجب أن تكون جميع النتائج والمعلومات **باللغة العربية الفصحى**، ويجب أن تخرج في تنسيق JSON وفق الهيكل المحدد تماماً أدناه، لتمكين التطبيق من قراءتها آلياً.
//
// {
//   "التقييم_الأولي_المهني": "ملخص شامل في جملة واحدة (يحدد الاتجاه العام للرسم: إيجابي، سلبي، قلق، صدمة).",
//   "المؤشرات_الفنية_المرصودة": ["حدد 3 إلى 5 مؤشرات فنية تم تحليلها (مثال: استخدام اللون الأسود بكثافة في مركز الرسم)."],
//   "الاضطرابات_المحتملة": ["حدد الاضطرابات التي قد يشير إليها الرسم (مثال: القلق العام، اضطراب ما بعد الصدمة، اكتئاب)."],
//   "تنبيه_الحاجة_للتدخل_العاجل": "الإجابة يجب أن تكون 'نعم' أو 'لا' فقط."
//
// """);
    final prompt = TextPart(promptText as String);


    try {
    final response = await model.generateContent([
    Content.multi([prompt, DataPart("image/jpeg", widget.imageFile)]),
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
    debugPrint("JSON Decoding Error: $e"); // استخدام debugPrint أفضل في Flutter
    return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 تحسين: وضع Directionality هنا يغطي الواجهة بفعالية
    return Directionality(
      textDirection: TextDirection.rtl, // تحديد اتجاه النص للعربية

      child: Scaffold(
        backgroundColor: Colors.white,

        // 🔥 تحسين: إضافة const للـ AppBar
        appBar: AppBar(
          title: const Text("تحليل الصورة"),
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // عرض الصورة
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.memory(
                  widget.imageFile,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              // زر بدء التحليل
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _analyzeChildEmotion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "بدء التحليل",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // عرض النتائج المُنظمة
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

              // عرض النص الخام في حالة حدوث خطأ أو عدم قراءة JSON
              if (!_isLoading && _analysis == null && _rawText != null)
                Text(
                  "حدث خطأ في قراءة JSON أو API. النص الخام:\n$_rawText",
                  style: const TextStyle(color: Colors.redAccent),
                  textDirection: TextDirection.rtl,
                ),
            ],
          ),
        ),
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
        color: const Color(0xfff1f1f5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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



















































































// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:typed_data';
// import 'package:google_generative_ai/google_generative_ai.dart';
//
// class AnalysiImagebyAiScreen extends StatefulWidget {
//   final Uint8List imageFile;
//
//   const AnalysiImagebyAiScreen({super.key, required this.imageFile});
//
//   @override
//   State<AnalysiImagebyAiScreen> createState() => _AnalysiImagebyAiScreenState();
// }
//
// class _AnalysiImagebyAiScreenState extends State<AnalysiImagebyAiScreen> {
//   Map<String, dynamic>? analysis;
//   bool isLoading = false;
//   String? rawText;
//
//   @override
//   void initState() {
//     super.initState();
//     analyzeChildEmotion();
//   }
//
//   Future<void> analyzeChildEmotion() async {
//     setState(() {
//       isLoading = true;
//       analysis = null;
//       rawText = null;
//     });
//
//     final model = GenerativeModel(
//       model: "gemini-2.5-flash",
//       apiKey: "AIzaSyCGO-IYBzaVIARV-o980oW46WFI7BiTPy8",
//     );
//
//     final prompt = TextPart("""
// أنت خبير نفسي مُعتمد ومتخصص في العلاج بالفن وتحليل رسومات الأطفال، ولديك خبرة عميقة في تشخيص اضطرابات ما بعد الصدمة (PTSD) واضطرابات القلق الناجمة عن التعرض للنزاعات والحروب.
//
// **السياق:**
// أنت بصدد تحليل رسم لطفل متضرر من الأحداث في قطاع غزة، ويجب أن يكون تحليلك مهنياً وموجهاً لدعم الأخصائيين النفسيين.
//
// **المهمة:**
// قم بتحليل الصورة المرفقة. يجب أن يُركز تقييمك النفسي الفني على استخلاص الدلالات المتعلقة بالصدمة، القلق، ومشاعر الفقد أو التهديد.
//
// **معايير التحليل الأساسية (ركز عليها جيداً):**
// 1.  **الألوان المستخدمة:** (مثل: سيادة الألوان الباردة/الداكنة، غياب الألوان الزاهية، الاستخدام المكثف للأحمر أو الأسود، التلوين العشوائي أو الخروج عن الحدود).
// 2.  **التكوين والتنظيم المكاني:** (مثل: الحجم الصغير جدًا للشخصيات، وضع الأشكال في زاوية واحدة، ازدحام العناصر، رسم خط أرضي مُهدد أو غير مستقر).
// 3.  **المحتوى الرمزي:** (مثل: رسم رموز العدوان/القصف، غياب الأشكال البشرية المهمة (الأهل)، رسم وجوه بدون ملامح أو عيون، رسم أشكال مغلقة أو مسجونة، تكرار الأشكال الحادة أو التخريب).
// 4.  **خطوط الرسم والضغط:** (مثل: الخطوط المتقطعة التي تعبر عن التردد أو القلق، الضغط الشديد على القلم الذي يعبر عن التوتر والغضب المكبوت، أو الخطوط الخفيفة جدًا).
//
// **المخرجات المطلوبة (بصيغة JSON حصراً):**
// يجب أن تكون جميع النتائج والمعلومات **باللغة العربية الفصحى**، ويجب أن تخرج في تنسيق JSON وفق الهيكل المحدد تماماً أدناه، لتمكين التطبيق من قراءتها آلياً.
//
// {
//   "التقييم_الأولي_المهني": "ملخص شامل في جملة واحدة (يحدد الاتجاه العام للرسم: إيجابي، سلبي، قلق، صدمة).",
//   "المؤشرات_الفنية_المرصودة": ["حدد 3 إلى 5 مؤشرات فنية تم تحليلها (مثال: استخدام اللون الأسود بكثافة في مركز الرسم)."],
//   "الاضطرابات_المحتملة": ["حدد الاضطرابات التي قد يشير إليها الرسم (مثال: القلق العام، اضطراب ما بعد الصدمة، اكتئاب)."],
//   "تنبيه_الحاجة_للتدخل_العاجل": "الإجابة يجب أن تكون 'نعم' أو 'لا' فقط."
// }
// """);
//
//     try {
//       final response = await model.generateContent([
//         Content.multi([prompt, DataPart("image/jpeg", widget.imageFile)]),
//       ]);
//
//       rawText = response.text;
//       analysis = _extractJson(rawText!);
//     } catch (e) {
//       rawText = "خطأ: $e";
//     }
//
//     setState(() => isLoading = false);
//   }
//
//   Map<String, dynamic>? _extractJson(String text) {
//     final start = text.indexOf('{');
//     final end = text.lastIndexOf('}');
//     if (start == -1 || end == -1) return null;
//
//     final json = text.substring(start, end + 1);
//
//     return {
//       "emotion": RegExp(
//         r'"المشاعر"\s*:\s*"([^"]+)"',
//       ).firstMatch(json)?.group(1),
//       // "confidence": RegExp(
//       //   r'"نسبة_الثقة"\s*:\s*"([^"]+)"',
//       // ).firstMatch(json)?.group(1),
//       "description": RegExp(
//         r'"الوصف"\s*:\s*"([^"]+)"',
//       ).firstMatch(json)?.group(1),
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       // 🔥 هنا الاتجاه من اليمين لليسار
//       textDirection: TextDirection.ltr,
//
//       child: Scaffold(
//         backgroundColor: Colors.white,
//
//         appBar: AppBar(
//           title: const Text("تحليل الصورة"),
//           backgroundColor: Colors.indigo,
//           centerTitle: true,
//           elevation: 0,
//         ),
//
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "تم استلام الصورة بنجاح",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(14),
//                 child: Image.memory(
//                   widget.imageFile,
//                   height: 240,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : analyzeChildEmotion,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.indigo,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: isLoading
//                       ? const SizedBox(
//                           height: 22,
//                           width: 22,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                       : const Text(
//                           "بدء التحليل",
//                           style: TextStyle(fontSize: 17, color: Colors.white),
//                         ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               if (analysis != null) ...[
//                 _buildResultCard("المشاعر المتوقعة", analysis!["emotion"]),
//                 // _buildResultCard("نسبة الثقة", analysis!["confidence"]),
//                 _buildResultCard(
//                   "وصف الحالة",
//                   analysis!["description"],
//                   maxLines: 10,
//                 ),
//               ],
//
//               if (!isLoading && analysis == null && rawText != null)
//                 Text(rawText!, style: const TextStyle(color: Colors.redAccent)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildResultCard(String title, String? value, {int maxLines = 4}) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: const Color(0xfff1f1f5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.indigo,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value ?? "غير متوفر",
//             style: const TextStyle(
//               fontSize: 15,
//               height: 1.4,
//               color: Colors.black87,
//             ),
//             maxLines: maxLines,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Future<Uint8List?> pickImage({required ImageSource source}) async {
//   final picker = ImagePicker();
//   final XFile? file = await picker.pickImage(source: source);
//   if (file == null) return null;
//   return await file.readAsBytes();
// }
