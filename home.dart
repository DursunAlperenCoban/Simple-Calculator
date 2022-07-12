// home.dart

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String div=new String.fromCharCodes(new Runes('\u00F7')); // division symbol
  List<String> button_caption=['C','DEL','%',new String.fromCharCodes(new Runes('\u00F7')),'7','8','9','x','4',
    '5','6','-','1','2','3','+','+/-','0','.','=']; // button texts
  String input='0';  // screen text
  String num1='',num2=''; // first and second numbers
  bool n1=false,n2=false; // flags to check entry of fist and second numbers
  double result=0.0; // the result
  String op=''; // arithmetic operation
  bool mz=false; // to check multiole zero in the beginning of second number
  bool secnd=false; // to check second operation
  bool decp1=false, decp2=false; // to check the decimal points of first and second numbers
  bool s1=false, s2=false; // to check the sign of first and second numbers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: SafeArea(
      child:CustomScrollView(
             slivers: [
                built_layout(),
            ],
            ),
      ),
    );
  }
  SliverList built_layout() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          textarea(),
          Divider(
            height: 3.0,
          ),
          buttonarea(),
          Divider(
            height: 3.0,
          ),
        ],
      ),
    );
  }
  Container textarea() {
    return Container(
            padding: EdgeInsets.all(0.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(
                  width:2,
                  color: Colors.black,
                )
            ),
            child: Text(
              '$input',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Courier',
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
  Stack buttonarea() {
    return Stack(
    children: [
        Container(
          padding: EdgeInsets.all(0.0),
          height: 520.0,
        ),
        Positioned.fill(
          child:GridView.builder(
            itemCount: 20,
            padding: EdgeInsets.all(0.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4
            ),
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(
                child: Text('${button_caption[index]}'),
                onPressed: (){
                  setState(() {
                    updateScreen(button_caption[index]);
                  });
                },
              style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
                textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold),
              ),
              );
            },
          ),
      ),
    ],
    );
  }
  void updateScreen(String inp){
    if(inp=='1' || inp=='2' || inp=='3' || inp=='4' || inp=='5' || inp=='6' ||
        inp=='7' || inp=='8' || inp=='9'){ // 1,2,3,4,5,6,7,8,9 buttons
    if(input=='0') {
      input='';
      input+=inp;
    }
    else if(n1 && input.endsWith('0') && mz==false){
      input=input.substring(0,input.length-1)+inp;
    }
    else if(secnd==true) {
      input=inp;
      secnd=false;
      s1=false;
    }
    else
      input+=inp;
    }
    else if(inp=='0'){ // 0 button
      if(input=='0') {
        input='0';
      }
      else if(n1 && !mz){
        if(input.endsWith('+') || input.endsWith('-') || input.endsWith('x') || input.endsWith(div) || input.endsWith('%'))
          input+='0';
        else if(input.endsWith('0') && mz==false)
          input=input;
        else {
          mz = true;
          input+='0';
        }
      }
      else if(secnd==true) {
        input=inp;
        s1=false;
        secnd=false;
      }
      else {
        input+=inp;
      }
    }
    else if(inp=='+' ||inp=='-' || inp=='x' || inp==div || inp=='%'){ // +,-,x,/,% buttons
      if(n1==false){
        num1=input.trim();
        n1=true;
        input+=inp;
        op=inp;
        secnd=false;
      }
    }
    else if(inp=='C'){ // C button
      input='0';
     reset();
    }
    else if(inp=='.'){ // . button
      if(!n1){
        if(!decp1 && !input.contains('.')){
          input+=inp;
          decp1=true;
          if(secnd)
            secnd=false;
        }
      }
      else{
        if(!decp2){
          if((input.endsWith('+') || input.endsWith('-') || input.endsWith('x') || input.endsWith(div) || input.endsWith('%')))
            input+='0.';
          else
            input+=inp;
          decp2=true;
        }
      }
    }
    else if(inp=='+/-'){ // +/- button
      if(!n1){
        if(input.compareTo('0')!=0) {
         if (!s1) {
          input = '-' + input;
          s1 = true;
        }
        else {
          input = input.substring(1);
          s1 = false;
        }
      }
      }
      else{
        if(input.substring(input.indexOf(op)+1).compareTo('0')!=0){
          if (!s2) {
            input = input.substring(0,input.indexOf(op)+1) + '-' + input.substring(input.indexOf(op)+1);
            s2 = true;
          }
          else {
            input = input.substring(0,input.indexOf(op)+1) + input.substring(input.indexOf(op)+2);
            s2 = false;
          }
        }
      }
    }
    else if(inp=='DEL') { // DEL button
      String def = input.substring(input.length - 1);
      if (!n1) {
        if (def != '.' && def != '-') {
          input = input.substring(0, input.length - 1);
        }
        else if(def=='.'){
          input = input.substring(0, input.length - 1);
          decp1=false;
        }
        else{
          input = input.substring(0, input.length - 1);
          s1=false;
        }
      }
      else {
        if (def != '.' && def != '-') {
          input = input.substring(0, input.length - 1);
        }
        else if(def=='.'){
          input = input.substring(0, input.length - 1);
          decp2=false;
        }
        else if(def=='-'){
          input = input.substring(0, input.length - 1);
          if(s2) {
            s2 = false;
          }
          else{
            n1=false;
            op='';
          }
        }
        else{
          input = input.substring(0, input.length - 1);
          n1=false;
          op='';
        }
      }
      if(input.length==0){
        input='0';
      }
    }
    else{  // = button
      if(n1 && !(input.endsWith('+') || input.endsWith('-') || input.endsWith('x') || input.endsWith(div) || input.endsWith('%'))){
        n2=true;
        num2=input.substring(input.indexOf(op)+1).trim();
        switch(op){
          case '+':
            result=double.parse(num1)+double.parse(num2);
            break;
          case '-':
            result=double.parse(num1)-double.parse(num2);
            break;
          case 'x':
            result=double.parse(num1)*double.parse(num2);
            break;
          case '%':
            result=double.parse(num1)%double.parse(num2);
            break;
          default:
            result=double.parse(num1)/double.parse(num2);
        }
        var outcome=result % 1 == 0 ? result.toInt() : result;
        input=outcome.toString();
        if(input.length>9)
          input=input.substring(0,9);
        secnd=true;
        n1=n2=mz=decp1=decp2=s2=false;
        num1=num2=op='';
        result=0.0;
        if(outcome<0)
          s1=true;
      }
    }
  }
  void reset(){
    n1=n2=mz=decp1=decp2=s1=s2=false;
    num1=num2=op='';
    result=0.0;
    secnd=false;
  }
}