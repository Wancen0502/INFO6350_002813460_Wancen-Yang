import 'package:flutter/material.dart';
import 'package:exercise_6a/Calculate.dart';


class IndexPage extends StatefulWidget {

  @override
  IndexPageState createState() {
    return new IndexPageState();
  }

}

class IndexPageState extends State<IndexPage>{

  // Colors
  static const Color PAGE_COLOR = Color(0XFFFFFFFF);
  static const Color NUMS_COLOR = Color(0XFFFFFFFF);
  static const Color EQUAL_COLOR = Color(0xFFff9500);
  static const Color OTHER_COLOR = Color(0xFFBEBEBE);
  static const Color SCREEN_COLOR = Color(0xFF333333);

  // Text On Button
  static const allKeys = [
    '7', '8', '9', 'x',
    '4', '5', '6', '/',
    '1', '2', '3', '+',
    '=', '0', 'C', '—',
  ];

  static const numsKeys = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  static const equalKeys = ['='];

  String _input = '';

  Calculate _cal = new Calculate();

  void clickKey(String key){
   // if("C".compareTo(key)==0){
    //  _input="";
    //  key="";
   // }
   // setState(() {
     // _input+=key;
   // });
    _cal.addKey(key);
    setState(() {
      _input = _cal.Output;
    });
  }


  Widget buildBtns(){
    List<Widget> rows=[];

    List<Widget> btns = [];

    for (int i=0; i<allKeys.length; i++){
      String key = allKeys[i];
      Widget btn = buildButton(key);
      btns.add(btn);
      if((i+1)%4==0){
        rows.add(Row(
          children:btns,
        ));
        btns = [];
      }
    }
    return Column(
        children:rows
    );
  }

  // Create Button
  Widget buildButton(String num, {int flex = 1}){
    return Expanded(
        flex:flex,
        child:TextButton(
            onPressed:()=>{
              clickKey(num)
            },
            style:TextButton.styleFrom(
                padding: EdgeInsets.zero, minimumSize: Size(100, 100)),
            child:Container(
                decoration: BoxDecoration(
                  color:numsKeys.contains(num)?NUMS_COLOR: equalKeys.contains(num)?EQUAL_COLOR:OTHER_COLOR,
                  shape:BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                padding:EdgeInsets.all(20.0),
                margin:EdgeInsets.all(10.0),
                child:Container(child: Text("$num",style:TextStyle(fontSize:25.0, color:Colors.black),))
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_COLOR,
      appBar:AppBar(
        title:Text("Calculator",style:TextStyle(
            color: PAGE_COLOR) ,),
        backgroundColor:SCREEN_COLOR,
        centerTitle:true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(color:SCREEN_COLOR,child:Column(children:<Widget>[
          Expanded(
            child:SingleChildScrollView(
              reverse:true,
              child: Padding(
              padding: EdgeInsets.all(20.0), // Adjust padding as needed
              child: Align(
                alignment: Alignment(1.0, 1.0),
                child: Text(
                  "$_input",
                  style: TextStyle(
                    color: PAGE_COLOR,
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
            ),
          ),
          Container(color:PAGE_COLOR,child:Center(
              child: buildBtns()
          )),
        ])),
      ) ,
    );
  }
}





