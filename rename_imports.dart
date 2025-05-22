import 'dart:developer';
import 'dart:io';

void main() async {
  const oldPackage = 'package:rifad/';
  const newPackage = 'package:alrefadah/';
  final libDir = Directory('lib');

  if (!libDir.existsSync()) {
    log('❌ مجلد lib غير موجود.');
    return;
  }

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));

  for (final file in dartFiles) {
    final content = await file.readAsString();

    if (content.contains(oldPackage)) {
      final newContent = content.replaceAll(oldPackage, newPackage);
      await file.writeAsString(newContent);
      log('✅ تم التعديل في: ${file.path}');
    }
  }

  log('\n🎉 تم استبدال جميع imports من rifad إلى alrefadah بنجاح.');
}

/// dart rename_imports.dart
