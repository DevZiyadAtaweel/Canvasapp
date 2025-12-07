// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:typed_data';
// import 'package:google_generative_ai/google_generative_ai.dart';

// // شاشة تحليل الصورة بالذكاء الاصطناعي
// class AnalysiImagebyAiScreen extends StatelessWidget {
//   // استقبال ملف الصورة الملتقطة هنا
//    //final XFile? imageFile;
//    Uint8List? imageFile;

//    Future<String> analyzeChildEmotion(Uint8List imageBytes) async {
//      final apiKey = "AIzaSyCGO-IYBzaVIARV-o980oW46WFI7BiTPy8";

//      final model = GenerativeModel(
//        model: "gemini-1.5-pro",
//        apiKey: apiKey,
//      );
// //النص الخاص بالذكاء لارساله
//      final content = [
//        Content.multi([
//          TextPart(
//              'As a child psychology expert analyzing drawings of children (3-12 years) with psychological disorders or autism:'

//                  '🔍 Immediate Observations:'
//                  '1. Color usage and symbolism'
//                  '2. Organization and detail level'
//                  ' 3. Element relationships'
//                  '💡 Initial Assessment:'
//                  ' - [Potential disorder 1]'
//                  '  - [Potential disorder 2]'

//                  '  ✨ Practical Parent Recommendations: '
//                  '• [Suggestion 1 - short & direct] '
//                  '• [Suggestion 2 - daily implementable] '
//                  '• [Suggestion 3 - emotional support]'

//                  ' ⚠️ Note: This is preliminary analysis only. Consult a professionalfor accurate diagnosis'
//          ),
//          DataPart("image/jpeg", imageBytes),
//        ])
//      ];

//      final response = await model.generateContent(content);

//      return response.text ?? "No response";
//    }
//    AnalysiImagebyAiScreen({super.key,  required this.imageFile});

//   @override
//   State<AnalysiImagebyAiScreen> createState() => _AnalysiImagebyAiScreenState();
// }

// class _AnalysiImagebyAiScreenState extends State<AnalysiImagebyAiScreen> {
//   Map<String, dynamic>? analysis;
//   bool isLoading = false;
//   String? rawText;

//   @override
//   void initState() {
//     super.initState();
//     analyzeChildEmotion();
//   }

//   Future<void> analyzeChildEmotion() async {
//     setState(() {
//       isLoading = true;
//       analysis = null;
//       rawText = null;
//     });

//     final model = GenerativeModel(
//       model: "gemini-2.5-flash",
//       apiKey: "AIzaSyCGO-IYBzaVIARV-o980oW46WFI7BiTPy8",
//     );

//     final prompt = TextPart("""
// حلل حالة الطفل الظاهرة في الصورة.

// أرجع فقط JSON التالي:

// {
//   "المشاعر": "",
//   "نسبة_الثقة": "",
//   "الوصف": ""
// }
// """);

//     try {
//       final response = await model.generateContent([
//         Content.multi([prompt, DataPart("image/jpeg", widget.imageFile)]),
//       ]);

//       rawText = response.text;
//       analysis = _extractJson(rawText!);
//     } catch (e) {
//       rawText = "خطأ: $e";
//     }

//     setState(() => isLoading = false);
//   }

//   Map<String, dynamic>? _extractJson(String text) {
//     final start = text.indexOf('{');
//     final end = text.lastIndexOf('}');
//     if (start == -1 || end == -1) return null;

//     final json = text.substring(start, end + 1);

//     return {
//       "emotion": RegExp(
//         r'"المشاعر"\s*:\s*"([^"]+)"',
//       ).firstMatch(json)?.group(1),
//       "confidence": RegExp(
//         r'"نسبة_الثقة"\s*:\s*"([^"]+)"',
//       ).firstMatch(json)?.group(1),
//       "description": RegExp(
//         r'"الوصف"\s*:\s*"([^"]+)"',
//       ).firstMatch(json)?.group(1),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       // 🔥 هنا الاتجاه من اليمين لليسار
//       textDirection: TextDirection.rtl,

//       child: Scaffold(
//         backgroundColor: Colors.white,

//         appBar: AppBar(
//           title: const Text("تحليل الصورة"),
//           backgroundColor: Colors.indigo,
//           centerTitle: true,
//           elevation: 0,
//         ),

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

//               const SizedBox(height: 16),

//               ClipRRect(
//                 borderRadius: BorderRadius.circular(14),
//                 child: Image.memory(
//                   widget.imageFile,
//                   height: 240,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               const SizedBox(height: 24),

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

//               const SizedBox(height: 20),

//               if (analysis != null) ...[
//                 _buildResultCard("المشاعر المتوقعة", analysis!["emotion"]),
//                 _buildResultCard("نسبة الثقة", analysis!["confidence"]),
//                 _buildResultCard(
//                   "وصف الحالة",
//                   analysis!["description"],
//                   maxLines: 10,
//                 ),
//               ],

//               if (!isLoading && analysis == null && rawText != null)
//                 Text(rawText!, style: const TextStyle(color: Colors.redAccent)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

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

// Future<Uint8List?> pickImage({required ImageSource source}) async {
//   final picker = ImagePicker();
//   final XFile? file = await picker.pickImage(source: source);
//   if (file == null) return null;
//   return await file.readAsBytes();
// }

// Future<String> analyzeChildEmotion(Uint8List imageBytes) async {
//   final apiKey = "YOUR_GOOGLE_API_KEY";

//   final model = GenerativeModel(
//     model: "gemini-1.5-pro",
//     apiKey: apiKey,
//   );

//   final content = [
//     Content.multi([
//       TextPart(
//         "As a child psychology expert analyzing drawings of children (3-12 years) with psychological disorders or autism:"

//         '🔍 Immediate Observations:'
//             '1. Color usage and symbolism'
//             '2. Organization and detail level'
//             ' 3. Element relationships'
//             '💡 Initial Assessment:'
//             ' - [Potential disorder 1]'
//             '  - [Potential disorder 2]'

//             '  ✨ Practical Parent Recommendations: '
//             '• [Suggestion 1 - short & direct] '
//             '• [Suggestion 2 - daily implementable] '
//             '• [Suggestion 3 - emotional support]'

//             ' ⚠️ Note: This is preliminary analysis only. Consult a professionalfor accurate diagnosis"'
//                   ),
//       DataPart("image/jpeg", imageBytes),
//     ])
//   ];

//   final response = await model.generateContent(content);

//   return response.text ?? "No response";
// }
