import 'dart:convert';

 class Question{
  final  int id;
  final  String questionType;
  final  String question;
  final  List<int> answer;
  final  List<String> options;

  Question({
    required this.id,
    required this.questionType,
    required this.question,
    required this.answer,
    required this.options});


  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionType: json['type'],
      question: json['question'],
      answer: List<int>.from(json['correct_answer']),
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': questionType,
      'question': question,
      'correct_answer': answer,
      'options': options,
    };
  }
 }


/*
  static List questionList = [
        {
          "id": 1,
          "category": "programming and coding",
          "type": "one-choice",
          "question": "What does SQL stand for?",
          "correct_answer": [0],
          "options": [
            "(A) Structured Query Language",
            "(B) Simple Query Language",
            "(C) Standard Question Language",
            "(D) Systematic Query Logic"
          ]
        },
        {
          "id": 2,
          "category": "programming and coding",
          "type": "one-choice",
          "question": "Which of the following is a front-end framework?",
          "correct_answer": [1],
          "options": [
            "(A) Django",
            "(B) React",
            "(C) Spring Boot",
            "(D) Flask"
          ]
        },
        {
          "id": 3,
          "category": "programming and coding",
          "type": "one-choice",
          "question": "Which protocol is commonly used for secure data transfer over the internet?",
          "correct_answer": [3],
          "options": [
            "(A) HTTP",
            "(B) FTP",
            "(C) SSH",
            "(D) HTTPS"
          ]
        },
        {
          "id": 4,
          "category": "programming and coding",
          "type": "one-choice",
          "question": "Which data structure follows the LIFO (Last In, First Out) principle?",
          "correct_answer": [2],
          "options": [
            "(A) Queue",
            "(B) Linked List",
            "(C) Stack",
            "(D) HashMap"
          ]
        },
        {
          "id": 5,
          "category": "programming and coding",
          "type": "one-choice",
          "question": "What is the primary purpose of a foreign key in a database?",
          "correct_answer": [2],
          "options": [
            "(A) To ensure data redundancy",
            "(B) To create a backup of data",
            "(C) To establish a relationship between two tables",
            "(D) To store encrypted data"
          ]
        },
        {
          "id": 6,
          "category": "programming and coding",
          "type": "true-or-false",
          "question": "Unit testing is the process of testing individual components or functions of a software system to ensure they work correctly in isolation.",
          "correct_answer": [0],
          "options": [
            "(A) True",
            "(B) False"
          ]
        },
        {
          "id": 7,
          "category": "programming and coding",
          "type": "true-or-false",
          "question": "In object-oriented programming, inheritance allows a class to inherit behaviors and properties from another class, but it can never be modified in the subclass.",
          "correct_answer": [1],
          "options": [
            "(A) True",
            "(B) False"
          ]
        },
        {
          "id": 8,
          "category": "programming and coding",
          "type": "true-or-false",
          "question": "Agile methodology emphasizes iterative development, where software is developed and delivered in small, incremental cycles called sprints.",
          "correct_answer": [0],
          "options": [
            "(A) True",
            "(B) False"
          ]
        },
        {
          "id": 9,
          "category": "programming and coding",
          "type": "multiple-choice",
          "question":  "Which of the following are key principles of Agile software development?",
          "correct_answer": [0,2],
          "options": [
            "A) Iterative development",
            "B) Strict documentation before development",
            "C) Customer collaboration",
            "D) Following a rigid project plan"
          ]
        },
        {
          "id": 10,
          "category": "programming and coding",
          "type": "multiple-choice",
          "question": "Which of the following is a common design pattern used in software development to create objects without specifying the exact class of object that will be created?",
          "correct_answer": [0,2],
          "options": [
            "A) Tracking and managing code changes",
            "B) Enhancing software execution speed",
            "C) Facilitating collaboration among developers",
            "D) Eliminating the need for debugging"
          ]
        },
  ];
  */















