import 'buttons.dart';
import 'package:flutter/material.dart';
import './testercal.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      //theme: ThemeData(
      // primarySwatch: Colors.grey,)
      debugShowCheckedModeBanner: false,
      home: TestCal(),
    );
  }
}

class _MyCalculator extends State<Calculator> {
  var userQues = '';
  var userAns = '';
  late List<String> buttons = [
    "AC",
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    "6",
    '5',
    '4',
    '+',
    "3",
    '2',
    '1',
    '-',
    "0",
    '.',
    '00',
    '=',
  ];
  /*String expr = '';

  String? get lOp => null;

  String? get rOp => null;
  
  void getInput(String userQues, String userAns) {

    if (userQues == '+' || userQues== '-' || userQues == '*' || userQues == '/') {
      userQues = expr;
      return;
    } else if (userQues == '=') {
      expr += compute(lOp!, rOp!, userQues);
      userAns += expr;
     // expr ='';
      return;
    };
  }

    compute(String l, String r, String userQues) {
    num lOp = num.parse(l);
    num rOp = num.parse(r);
    switch (userQues) {
      case '+':
        return (lOp + rOp).toString();
      case '-':
        return (lOp - rOp).toString();
      case '*':
        return (lOp * rOp).toString();
      case '/':
        return (lOp / rOp).toString();
       //Here, we used switch statement...
      default:
        return '0';
    }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
                child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Container(
                  padding: EdgeInsets.all(50),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQues,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAns,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                )
              ],
            )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                      ///This helps to divide the list of strings into Sections of 4
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    //DELETE BUTTON
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQues = "";
                            userAns = "";
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQues =
                                userQues.substring(0, userQues.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.deepOrangeAccent,
                      );
                    }
                    //EQUAL BUTTON
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                            //getInput(userQues, userAns);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple[50],
                        textColor: Colors.black,
                      );
                    }

                    //REST OF THE BUTTONS
                    else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQues += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple[50]
                            : Colors.deepPurple,
                        textColor: isOperator(buttons[index])
                            ? Colors.black
                            : Colors.deepPurple[50],
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == "/" || x == "*" || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    //we user dart math function imported above
    String finalQuestion = userQues;

    //finalQuestion becomes userQues(a String)
    // finalQuestion = finalQuestion.replaceAll('*', 'x');
    Parser p = Parser();
    //p ..here refers to the String in userQues

    Expression exp = p.parse(finalQuestion);
    // the above  converts the string to a math expression

    ContextModel cm = ContextModel();
    //ContextModel() ..from math_expressions.dart
    //Go.. look it up!

    double eval = exp.evaluate(EvaluationType.REAL, cm);
    //Then .. this evaluates code "exp" to give the mathmatical output(Expression!)
    //Notice.. we used 'double'!

    List splited = eval.toString().split(RegExp(r"\."));
    userAns = splited[1] == '0' ? eval.round().toString() : eval.toString();
    //we call the 'userAns' which is (an empty String)
    //and make it equal to the 'eval', then push 'eval' toString()
    //Making 'eval' received as the final output in 'userAns'!
  }
}

class Calculator extends StatefulWidget {
  @override
  _MyCalculator createState() {
    return _MyCalculator();
  }
}
