// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  btnPressed(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (btnText == '⌫') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  btnResult() {
    setState(() {
      equationFontSize = 38.0;
      resultFontSize = 48.0;
      expression = equation;
      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('÷', '/');
      try {
        Parser p = new Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        result = 'error';
      }
    });
  }

  Widget buildButton(String btnText, double btnHeight, Color txtcolor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      child: ElevatedButton(
        style: TextButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () => btnPressed(btnText),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: txtcolor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('My Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    equation,
                    style: TextStyle(
                        fontSize: equationFontSize, color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    result,
                    style: TextStyle(
                        fontSize: resultFontSize, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('AC', 1, Colors.orange),
                        buildButton('⌫', 1, Colors.orange),
                        buildButton('%', 1, Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.white),
                        buildButton('8', 1, Colors.white),
                        buildButton('9', 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.white),
                        buildButton('5', 1, Colors.white),
                        buildButton('6', 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.white),
                        buildButton('2', 1, Colors.white),
                        buildButton('3', 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('00', 1, Colors.white),
                        buildButton('0', 1, Colors.white),
                        buildButton('.', 1, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [buildButton('÷', 1, Colors.orange)]),
                    TableRow(children: [buildButton('x', 1, Colors.orange)]),
                    TableRow(children: [buildButton('-', 1, Colors.orange)]),
                    TableRow(children: [buildButton('+', 1, Colors.orange)]),
                    TableRow(children: [
                      Container(
                        height: 70,
                        margin: EdgeInsets.all(8),
                        // color: Colors.amber,
                        child: ElevatedButton(
                            onPressed: btnResult,
                            style: TextButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.orange,
                            ),
                            child: IconButton(
                              onPressed: null,
                              icon: Image.asset('assets/equal_sign.png'),
                              iconSize: 20.0,
                            )),
                      )
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
