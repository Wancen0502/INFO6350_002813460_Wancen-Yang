import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hackathon/Question.dart';

class questionService {
  static Future<List<Question>> loadQuestions() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/db.json');

      List<dynamic> jsonData = jsonDecode(jsonString);

      return jsonData.map((q) => Question.fromJson(q)).toList();
    } catch (e) {
      print("Error loading questions: $e");
      return [];
    }
  }
}