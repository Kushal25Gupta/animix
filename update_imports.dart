import 'dart:io';
import 'dart:convert';

void main() async {
  // Get all dart files in lib and test directories
  final Process process = await Process.start(
    'find',
    ['lib', 'test', '-name', '*.dart'],
    runInShell: true,
  );

  final List<String> files = [];
  await for (var line in process.stdout.transform(utf8.decoder).transform(const LineSplitter())) {
    files.add(line);
  }

  for (var file in files) {
    final content = await File(file).readAsString();
    final updated = content.replaceAll(
      "import 'package:aniflix/",
      "import 'package:animix/",
    );
    
    if (content != updated) {
      await File(file).writeAsString(updated);
      print('Updated imports in $file');
    }
  }

  print('All imports updated successfully!');
} 