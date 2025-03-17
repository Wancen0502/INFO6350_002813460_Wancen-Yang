import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon/QuestionController.dart';
import 'package:hackathon/StartPage.dart';


class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    QuestionController controller = Get.put(QuestionController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget> [
          SafeArea(
            child:Padding(
              padding:EdgeInsets.symmetric(horizontal:15),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:<Widget>[
                  Container(
                    width:MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height/2,
                    decoration:BoxDecoration(
                      image:DecorationImage(
                        image:AssetImage('../assets/images/start.jpg'),
                        fit:BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child:Text(
                      "Testing your basic knowledge of software devloping",
                      style:TextStyle(
                        fontSize:20,
                        fontWeight:FontWeight.bold,
                        color:Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height:35),
                  Container(
                    child:TextField(
                      onChanged:(text) => controller.userName = text,
                      decoration:InputDecoration(
                        hintText: 'Please enter your name',
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                 SizedBox(height:15),
                  Container(
                    child:SizedBox(
                      height:65,
                      width:MediaQuery.of(context).size.width,
                      child:ElevatedButton(
                        child:Text("Ready to Start"),
                        onPressed: (){
                          Get.to(()=>StartPage()
                          );
                        },
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}