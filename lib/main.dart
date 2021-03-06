import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Question_brain.dart';
//import 'Questions.dart';

Question_brain questionBrain=Question_brain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> schoolkeeper=[];
  int tracker1,tracker2;

  void checkAnswer(bool userAnswer){
    setState(() {
      if(userAnswer==questionBrain.getAnswer()){
        schoolkeeper.add(Icon(Icons.check,color: Colors.green,));
      }
      else{
        schoolkeeper.add(Icon(Icons.close,color: Colors.red,));
      }


      if(questionBrain.getQnumber()==questionBrain.getQbookLength()-1){
        Alert(context: context, title: "Alert", desc: "Questions Finished").show();
        schoolkeeper=[];
        questionBrain.restQuestions();
      }
      else{
        questionBrain.nextQuestion();
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: schoolkeeper,
        ),
      ],
    );
  }
}

