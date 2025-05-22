import 'dart:io';

void main() async {
  const oldPackage = 'package:rifad/';
  const newPackage = 'package:alrefadah/';
  final libDir = Directory('lib');

  if (!libDir.existsSync()) {
    print('❌ مجلد lib غير موجود.');
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
      print('✅ تم التعديل في: ${file.path}');
    }
  }

  print('\n🎉 تم استبدال جميع imports من rifad إلى alrefadah بنجاح.');
}
/// dart rename_imports.dart