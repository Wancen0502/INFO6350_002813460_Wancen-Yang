import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hackathon/Question.dart';
import 'package:hackathon/ScorePage.dart';
import 'package:flutter/services.dart' show rootBundle;


class QuestionController extends GetxController with SingleGetTickerProviderMixin {

  //name of user
  String _userName = "";
  String get userName => this._userName;

  set userName(String name){
    this._userName = name;
  }


  late AnimationController _animationController;

  late Animation _animation;
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this. _pageController;

  // if the question has been answer
  bool _isAnswered  = false;
  bool get isAnswer=> this._isAnswered;

  List<int> _correctAnswer = [];
  List<int> get correctAnswer => this. _correctAnswer;

  List<int> _selectedAnswer = [];
  List<int> get selectedAnswer => this. _selectedAnswer;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numberOfCorrectAnswer = 0;
  int get numberOfCorrectAnswer => this._numberOfCorrectAnswer;

  List<Question> questions = [];

//Load 10 questions in random.
  /*
  List<Question> questions = (Question.questionList..shuffle())
      .take(10)
      .map((q) => Question(
    id: q['id'],
    questionType: q['type'],
    question: q['question'],
    answer: q['correct_answer'],
    options: q['options'],
  )).toList();

   */

  void loadQuestions() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/db.json');
      List<dynamic> jsonData = jsonDecode(jsonString);

      List<Question> loadedQuestions = jsonData.map((q) => Question.fromJson(q)).toList();
      loadedQuestions.shuffle();
      questions = loadedQuestions.take(10).toList();

    } catch (e) {
      print("Error loading questions: $e");
    }
  }

  List<Question> get question=>this.questions;

  @override
  void onInit(){
    _animationController =
        AnimationController(duration:Duration(seconds:60), vsync:this);
    _animation = Tween<double>(begin: 0,end:1).animate(_animationController)
    ..addListener((){
      update();
    });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    loadQuestions();
    super.onInit();

  }

  @override
  void onClose(){
      super.onClose();
      _animationController.dispose();
      _pageController.dispose();
  }

  // record users answer
  void recordAnswer(Question question, int selectedIndex) {
    if (question.questionType == 'multiple-choice') {
      if (_selectedAnswer.contains(selectedIndex)) {
        _selectedAnswer.remove(selectedIndex);
      } else {
        _selectedAnswer.add(selectedIndex);
      }
    }
    else {
      if (_selectedAnswer.isNotEmpty) {
        _selectedAnswer.clear();
      }
      _selectedAnswer.add(selectedIndex);
    }

    print("Selected Answers: $_selectedAnswer");
  }


  String getQuestionType(Question question){
    return question.questionType;
  }

// check if user's answer is correct
  void checkAnswer(Question question) {
    _isAnswered = true;
    _correctAnswer = question.answer;

    bool isCorrect = false;

    if (question.questionType == 'multiple-choice') {
      if (_selectedAnswer.toSet().containsAll(_correctAnswer) &&
          _correctAnswer.toSet().containsAll(_selectedAnswer)) {
        isCorrect = true;
      }
    }
    else if (_selectedAnswer.length == 1 && _correctAnswer.contains(_selectedAnswer.first)) {
      isCorrect = true;
    }

    if (isCorrect) {
      _numberOfCorrectAnswer++;
    }

    _animationController.stop();
    update();


    Future.delayed(Duration(seconds: 1), () {
      _selectedAnswer.clear();
      nextQuestion();
    });
  }


  // view next questions
  void nextQuestion(){
    if(_questionNumber.value != questions.length){
      _isAnswered = false;
      _pageController.nextPage(
        duration: Duration(microseconds:250),curve:Curves.ease
      );
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    }else{
      Get.to(()=>ScorePage()
      );
    }
  }


  void updateQuestionNumber(int index){
    _questionNumber.value = index+1;
  }

  // reset the whole App
  void resetSystems(){
    onInit();
    _userName = "";
    _isAnswered  = false;
    _correctAnswer = [];
    _questionNumber = 1.obs;
    _selectedAnswer = [];
    _numberOfCorrectAnswer = 0;
  }
}

