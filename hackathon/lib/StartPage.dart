import 'package:flutter/material.dart';
import'package:hackathon/QuestionPage.dart';
import'package:hackathon/QuestionController.dart';
import 'package:hackathon/HomePage.dart';
import 'package:hackathon/ScorePage.dart';
import 'package:get/get.dart';


class StartPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    QuestionController _controller = Get.put(QuestionController());

    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation:0,
        leading: GestureDetector(
            onTap:()=> {
              Get.to(()=>HomePage())
            },
            child:Icon(
              Icons.navigate_before,
              color:Colors.black54,
            )
        ),
        actions:[
          TextButton(
            onPressed:() {
              _controller.nextQuestion();
            },
            child:Text('Skip'),
          ),
        ],
      ),
      body: QuestionPage(),
    );
  }


}