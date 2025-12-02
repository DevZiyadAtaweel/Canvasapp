import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  static final _client = Supabase.instance.client;

  /// يرفع صورة طفل ويعيد الرابط العام لها
  static Future<String> uploadChildImage({
    required File file,
    required String userId,
    required String childId,
  }) async {
    final ext = file.path.split('.').last;
    final filePath = 'children/$userId/$childId.$ext'; // مسار داخل البكت

    // اسم البكت لازم يكون نفس اللي أنشأتيه في Supabase Storage
    const bucketName = 'children';

    await _client.storage
        .from(bucketName)
        .upload(filePath, file, fileOptions: const FileOptions(upsert: true));

    final publicUrl = _client.storage.from(bucketName).getPublicUrl(filePath);

    return publicUrl;
  }
}
