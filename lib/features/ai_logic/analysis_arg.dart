import 'dart:typed_data';

import 'package:moftahak/features/home/model/child_model.dart';

class AnalysisArgs {
  final Uint8List imageBytes;
  final String imageFilePath;
  final String childId;
  final ChildModel child;

  AnalysisArgs({
    required this.imageBytes,
    required this.imageFilePath,
    required this.childId,
    required this.child,
  });
}
