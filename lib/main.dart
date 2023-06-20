import 'package:flutter/material.dart';
import 'quizlogic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizLogic quizzlerLogic = QuizLogic();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Quizzler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variables
  List<Widget> scoreBoard = [];
  int correctAnswers = 0;
  int questionlength = quizzlerLogic.lengthOfQuestions();

  // Method that checks user's answer
  void checkAnswer(answerOfUser){
    // If questions are finished
    if(quizzlerLogic.isFinished()){
      // Show this alert
      Alert(
          context: context,
          title: "End of Quiz",
          desc: "You had $correctAnswers out of $questionlength. Thanks for playing!!",
          type: AlertType.success
      ).show();
      setState(() {
        // Reset question number to one
        quizzlerLogic.reset();
        // Reset scoreboard
        scoreBoard = [];
      });
      // Reset number of correct answers
      correctAnswers = 0;
    }
    else{
      bool rightAnswer = quizzlerLogic.getAnswer();
      if(rightAnswer == answerOfUser){
        setState(() {
          scoreBoard.add(
              const Icon(Icons.check, color: Colors.green,)
          );
        });
        // Increment number of correct answers by 1
        correctAnswers++;
      }
      else{
        setState(() {
          scoreBoard.add(
              const Icon(Icons.close,
                color: Colors.red,)
          );
        });
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      quizzlerLogic.getQuestionContent(), style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextButton(onPressed: (){
                    // Check user's answer
                    checkAnswer(true);
                    // Go to next question
                    quizzlerLogic.nextQuestion();
                }, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)), child: const Text("True", style: TextStyle(fontSize: 20, color: Colors.white),),),
              )),
              Expanded(
                child: Padding(
                padding: const EdgeInsets.all(15),
                 child: TextButton(onPressed: (){
                     // check user's answer
                     checkAnswer(false);
                     // Move on to next question
                     quizzlerLogic.nextQuestion();

                }, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)), child: const Text("False", style: TextStyle(fontSize: 20, color: Colors.white),)),
              ),
              ),
              Row(children: scoreBoard)
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
