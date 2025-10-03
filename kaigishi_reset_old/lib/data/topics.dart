// lib/data/topics.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Topics {
  final Map<String, String> labelsJa;
  final Map<int, List<String>> gradeMap;
  Topics({required this.labelsJa, required this.gradeMap});

  static Future<Topics> loadSafe() async {
    try {
      final raw = await rootBundle.loadString('assets/config/topics.json');
      final j = jsonDecode(raw) as Map<String, dynamic>;

      final labels = <String, String>{};
      final tMap = (j['topics'] as Map<String, dynamic>? ?? const {});
      tMap.forEach((k, v) {
        if (v is Map && v['ja'] is String) labels[k] = v['ja'] as String;
      });

      final grades = <int, List<String>>{};
      final gMap = (j['grades'] as Map<String, dynamic>? ?? const {});
      gMap.forEach((g, list) {
        final id = int.tryParse(g.toString());
        if (id != null && list is List) {
          grades[id] = List<String>.from(list);
        }
      });

      return Topics(labelsJa: labels, gradeMap: grades);
    } catch (_) {
      // フォールバック（最低限1級だけ空トピック）
      return Topics(labelsJa: const {}, gradeMap: const {1: []});
    }
  }
}
