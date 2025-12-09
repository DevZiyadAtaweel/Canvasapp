import 'dart:typed_data';

class AnalysisArgs {
  final Uint8List imageBytes;
  final String imageFilePath;
  final String childId;

  AnalysisArgs({
    required this.imageBytes,
    required this.imageFilePath,
    required this.childId,
  });
}
