import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'quiz_brain.dart';

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
  List<Icon> scoreKeeper = [];
  int scoreCount = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
      //HINT! Step 4 Part B is in the quiz_brain.dart
      //TODO: Step 4 Part C - reset the questionNumber,
      //TODO: Step 4 Part D - empty out the scoreKeeper.
      //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇

      if (quizBrain.isFinished()) {
        int quizLength = quizBrain.getQuestionBankLength();
        if ((scoreCount.toDouble() / quizLength.toDouble()) < 0.25) {
          Alert(
                  context: context,
                  title: "Quiz Completed",
                  desc:
                      "Better Luck Next Time.  You scored $scoreCount out of $quizLength")
              .show();
        } else if ((scoreCount.toDouble() / quizLength.toDouble()) < 0.5) {
          Alert(
                  context: context,
                  title: "Quiz Completed",
                  desc: "Nice Try.  You scored $scoreCount out of $quizLength")
              .show();
        } else if ((scoreCount.toDouble() / quizLength.toDouble()) < 0.75) {
          Alert(
                  context: context,
                  title: "Quiz Completed",
                  desc: "Good Job.  You scored $scoreCount out of $quizLength")
              .show();
        } else if ((scoreCount.toDouble() / quizLength.toDouble()) < 1.0) {
          Alert(
                  context: context,
                  title: "Quiz Completed",
                  desc: "Great Job!  You scored $scoreCount out of $quizLength")
              .show();
        } else {
          Alert(
                  context: context,
                  title: "Quiz Completed",
                  desc:
                      "You Nailed It and got a perfect score of $scoreCount out of $quizLength")
              .show();
        }
        quizBrain.reset();
        scoreKeeper.clear();
        scoreCount = 0;
      } else {
        if (userPickedAnswer == correctAnswer) {
          print('user got it right!');
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          scoreCount++;
        } else {
          print('user got it wrong.  :(');
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
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
                quizBrain.getQuestionText(),
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
                //The user picked true.
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
        Wrap(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
Icon(
              Icons.check,
              color: Colors.green,
            ),
            Icon(
              Icons.close,
              color: Colors.red,
            ),
 */

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

/*
Ari's Questions:
Q1: What is Ari's favourite colour? Yellow, **Pink**, Blue, Purple, 2
Q2: What is Ari's favourite food? **Pizza**, Chicken Nuggets, Tacos, Shrimp, 1
Q3: What is Ari's favourite dippin dots flavour? Cookies and Cream, Cotton Candy, **Chocolate Chip Cookie Dough**, Chocolate, 3
Q4: What is Ari's favourite LOL doll? Kitty Queen, **Neon QT**, Drag Racer, Ice Sk8er, 2
Q5: Which Youtube channel is Ari's Favourite? **Tic Tac Toy**, Ryan's Toy Review, Cookie Swirl C, Kimmi The Clown, 1
Q6: Who is Ari's favourite singer? Ariana Grande, Justin Bieber, Imagine Dragons, **Jojo Siwa**, 4
Q7: What is Ari's favourite song? Into the Unknown, The Middle, Happier, **Radioactive**, 4
Q8: What is Ari's favourite iPhone game? Slither.io, Tag with Ryan, **Barbie Dreamhouse Adventures**, Subway Surfer, 3
Q9: What is Ari's favourite Netflix show? **44 Cats**, Paw Patrol, Barbie Dreamhouse Adventures, Abby Hatcher , 1
Q10: What is Ari's favourite movie? Trolls, **Frozen 2**, Moana, Boss Baby, 2
Q11: What is Ari's favourite cooking show? Nailed It!, **Sugar Rush**, The Big Family Cooking Showdown, Zumbo's Just Desserts, 2
Q12: What is Ari's favourite chocolate bar? **Kinder Bueno**, Aero, Kit Kat, Coffee Crisp, 1
Q13: What is Ari's favourite drink? Water, Apple Juice, Orange Juice, **Rice Milk**, 4
Q14: What is Ari's favourite fruit? Raspberries, Strawberries, **Watermelon**, Canteloupe, 3
Q15: What is Ari's favourite animal? Dog, **Cat**, Horse, Unicorn, 2
Q16: Who is Ari's favourite Disney princess? Belle, **Ariel**, Rapunzel, Sleeping Beauty, 2
Q17: What is Ari's favourite household chore? **Sweeping**, Vacuuming, Cleaning Rusty's Litterbox, Scrubbing the Toilet, 1
Q18: What is Ari's favourite school subject? Social Studies, **Math**, Science, Reading, 2
Q19: Where was Ari's favourite trip? Grand Bend, Punta Cana, **Montego Bay**, Peterborough, 3
Q20: What is Ari's favourite video game? Kirby, Just Dance, **Days Gone**, Mario Kart, 3
*/
