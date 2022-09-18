import 'package:flutter/material.dart';

class QuizAnswerScreen extends StatelessWidget {
  final Map<String, dynamic> currentQuiz;
  final bool userAnswer;

  const QuizAnswerScreen({
    Key? key,
    required this.currentQuiz,
    required this.userAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isAnswerCorrect = currentQuiz['answer_bool'] == userAnswer;

    return Scaffold(
      appBar: AppBar(
        title: isAnswerCorrect ? const Text('Correct') : const Text('Wrong'),
        centerTitle: true,
        backgroundColor: isAnswerCorrect ? Colors.green : Colors.red,
      ),
      body: Container(
        color: isAnswerCorrect ? Colors.lightGreen[100] : Colors.redAccent[100],
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  currentQuiz['answer_desc'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  currentQuiz['answer_bool'].toString().toUpperCase(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
