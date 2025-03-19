import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/HomePage.dart';
import 'package:hackathon/QuestionController.dart';
import 'package:get/get.dart';

class ScorePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    QuestionController controller = Get.put(QuestionController());

    return Scaffold(
      backgroundColor:Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:GestureDetector(
          onTap:()=>{
            controller.resetSystems(),
            Get.to(()=>HomePage()
          )},
          child:Icon(
            Icons.refresh,
            color:Colors.black54,
          ),
        ),
      ),
      body: Stack(
        fit:StackFit.expand,
        children:<Widget>[
          Column(
            children:<Widget>[
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height/2,
                decoration:BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage('../assets/images/score.jpg'),
                    fit:BoxFit.fitWidth,
                  )
                ),
              ),
              Text(
                '${controller.userName}, your score:',
                style:Theme.of(context)
                .textTheme
                .headlineSmall
              ),
              Text(
                  (controller.numberOfCorrectAnswer == 0)
                      ?'0/${controller.questions.length}'
                      : "${controller.numberOfCorrectAnswer}/${controller.questions.length}",
                  style:Theme.of(context).textTheme.headlineSmall
              ),
            ],
          ),

        ]
      )
    );

  }
}