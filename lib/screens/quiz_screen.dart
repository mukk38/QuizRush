import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool? isCorrect;

  final List<Question> questions = [
    Question(
      questionText: "What is the capital of France?",
      options: ["London", "Berlin", "Paris", "Madrid"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "Which planet is known as the Red Planet?",
      options: ["Venus", "Mars", "Jupiter", "Saturn"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Which element has the chemical symbol 'Au'?",
      options: ["Silver", "Copper", "Gold", "Aluminum"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "Who painted the Mona Lisa?",
      options: ["Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso", "Michelangelo"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "What is the largest ocean on Earth?",
      options: ["Atlantic Ocean", "Indian Ocean", "Southern Ocean", "Pacific Ocean"],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: "In which year did World War II end?",
      options: ["1943", "1944", "1945", "1946"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "What is the largest mammal in the world?",
      options: ["African Elephant", "Blue Whale", "Giraffe", "Polar Bear"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Which programming language was Flutter built with?",
      options: ["Java", "Python", "Dart", "JavaScript"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "What is the capital of Japan?",
      options: ["Seoul", "Beijing", "Tokyo", "Bangkok"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "Who wrote 'Romeo and Juliet'?",
      options: ["Charles Dickens", "William Shakespeare", "Jane Austen", "Mark Twain"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "What is the speed of light approximately?",
      options: ["299,792 km/s", "199,792 km/s", "399,792 km/s", "499,792 km/s"],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: "Which planet is closest to the Sun?",
      options: ["Venus", "Mars", "Mercury", "Earth"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "What is the chemical formula for water?",
      options: ["CO2", "H2O", "O2", "N2"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Who is known as the father of computers?",
      options: ["Charles Babbage", "Alan Turing", "Bill Gates", "Steve Jobs"],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: "What is the largest planet in our solar system?",
      options: ["Saturn", "Jupiter", "Uranus", "Neptune"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Which country is home to the kangaroo?",
      options: ["New Zealand", "South Africa", "Australia", "Brazil"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "What is the hardest natural substance on Earth?",
      options: ["Gold", "Iron", "Diamond", "Platinum"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "Who developed the theory of relativity?",
      options: ["Isaac Newton", "Albert Einstein", "Niels Bohr", "Marie Curie"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "What is the main component of the Sun?",
      options: ["Helium", "Oxygen", "Carbon", "Hydrogen"],
      correctAnswerIndex: 3,
    ),
  ];

  void checkAnswer(int selectedIndex) {
    if (isCorrect != null) return; // Prevent multiple answers

    setState(() {
      isCorrect = selectedIndex == questions[currentQuestionIndex].correctAnswerIndex;
      if (isCorrect!) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          isCorrect = null;
        } else {
          // Show results dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Quiz Complete!'),
              content: Text('Your score: $score/${questions.length}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      currentQuestionIndex = 0;
                      score = 0;
                      isCorrect = null;
                    });
                  },
                  child: const Text('Restart Quiz'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Score: $score',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ...List.generate(
              questions[currentQuestionIndex].options.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: isCorrect == null
                        ? null
                        : index == questions[currentQuestionIndex].correctAnswerIndex
                            ? Colors.green
                            : isCorrect == false &&
                                    index != questions[currentQuestionIndex].correctAnswerIndex
                                ? null
                                : Colors.red,
                  ),
                  onPressed: isCorrect == null ? () => checkAnswer(index) : null,
                  child: Text(
                    questions[currentQuestionIndex].options[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
