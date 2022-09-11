import 'package:flutter/material.dart';
import 'package:quizzler_app/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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
  List<Icon> trackScores = [];

  int qustionNumber = 0;
  void createAlert() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: "You have reach the end of the question",
      buttons: [
        DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              qustionNumber = 0;
              trackScores.clear();
            });

            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  void checkAnswers(bool pickedAnswer) {
    bool pickedAnswer = true;
    bool correctAnswer = quizBrain.getquestionAnswer(qustionNumber);
    if (correctAnswer == pickedAnswer) {
      trackScores.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      trackScores.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
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
                quizBrain.getquestionText(qustionNumber),
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
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                qustionNumber++;
                setState(() {
                  if (qustionNumber == quizBrain.getAllQuestion()) {
                    createAlert();
                  }
                  checkAnswers(true);
                });
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                qustionNumber++;
                setState(() {
                  if (qustionNumber == quizBrain.getAllQuestion()) {
                    createAlert();
                  }
                  checkAnswers(false);
                });

                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: trackScores,
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
