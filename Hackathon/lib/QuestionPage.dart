import 'package:flutter/material.dart';
import 'package:hackathon/Question.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/QuestionController.dart';

class QuestionPage extends StatelessWidget{

  const QuestionPage({super.key});


  @override
  Widget build(BuildContext context) {

   QuestionController _controller = Get.put(QuestionController());

    return Stack(
      children: <Widget>[
        SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 12),
              child:Container(
                width:MediaQuery.of(context).size.width,
                height:55,
                decoration:BoxDecoration(
                  border:Border.all(
                    color:Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:GetBuilder<QuestionController>(
                  init:QuestionController(),
                  builder:(controller){
                    return Stack(
                      children:<Widget>[
                        LayoutBuilder(
                          builder:(context,constraints)=>Container(
                            width:constraints.maxWidth * _controller.animation.value,
                            decoration: BoxDecoration(
                              gradient:LinearGradient(
                                colors:[
                                  Colors.black54,
                                  Colors.black12,
                                ],
                                begin:Alignment.centerLeft,
                                end:Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child:Padding(
                            padding:EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text(
                                  "${(controller.animation.value*60).round()} sec",
                                  style:TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.access_alarm,
                                ),
                              ],
                            )
                          )
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height:12,
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:12),
              child:Obx(
                  ()=>Text.rich(
                    TextSpan(
                      text:"${_controller.questionNumber.value}",
                      style:Theme.of(context)
                        .textTheme
                        .headlineLarge,
                      children: [
                        TextSpan(text:"/${_controller.questions.length}",
                          style:Theme.of(context)
                              .textTheme
                              .headlineMedium,
                            ),
                        ],
                    ),
                  ),
              ),
            ),
            Divider(
              thickness:1.5,
            ),
            SizedBox(height:12,),
            Expanded(
                child:PageView.builder(
                  physics:NeverScrollableScrollPhysics(),
                  controller: _controller.pageController,
                  onPageChanged: _controller.updateQuestionNumber,
                  itemCount: _controller.questions.length,
                  itemBuilder: (context,index)=>QuestionCard(
                    question:_controller.questions[index],
                  ),
                ) )

          ],
        ),
      ),]
    );
  }
}

class QuestionCard extends StatelessWidget{

  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {

    QuestionController _controller =Get.put(QuestionController());
    // TODO: implement build
    return Container(
      margin:EdgeInsets.symmetric(horizontal:12),
      padding:EdgeInsets.all(15),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(25),
        border:Border.all(color:Colors.black12),
      ),
      child: Column(
      children:<Widget>[
        SizedBox(
          height:15,
        ),
        Text(
          question.question,
          style: Theme.of(context)
            .textTheme
            .headlineSmall
        ),
        SizedBox(
          height:12,
        ),
          ...List.generate(
            question.options.length,
                (index) => Options(
              index: index,
              text: question.options[index],
              press: () => _controller.recordAnswer(question, index),
            ),
          ),
        if (question.answer.length >= 1)
          ElevatedButton(
            onPressed: ()=>_controller.checkAnswer(question),
            child: Text("Next Quesiton"),
        ),
        ],
      ),
    );
  }
}


class Options extends StatelessWidget {

  final String text;
  final int index;
  final VoidCallback press;

  const Options(
      {super.key, required this.text, required this.index, required this.press});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (controller) {
        return InkWell(
          onTap: press,
          child: Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${index + 1}$text",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    height:26,
                    width:26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border:Border.all(color:Colors.black45),
                    ),
                    child: getIcon(controller, index) == true?
                        Icon(
                          Icons.done,
                          size:16,
                        ):null
                  ),
                ],
              )
          ),
        );
      },
    );
  }


  bool getIcon(QuestionController controller, int index) {
    if (controller.selectedAnswer.contains(index)) {
      return true;
    }
    return false;
  }
}








