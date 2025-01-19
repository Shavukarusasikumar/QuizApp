import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/views/result_view.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _showFeedback = false;
  bool? _isCorrect;

  void _showAnswerFeedback(bool isCorrect) {
    setState(() {
      _showFeedback = true;
      _isCorrect = isCorrect;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showFeedback = false;
          _isCorrect = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null) {
          return Scaffold(
            body: Center(child: Text('Error: ${state.error}')),
          );
        }

        if (state.quizData == null) {
          return const Scaffold(
            body: Center(child: Text('No quiz data available')),
          );
        }

        if (state.currentQuestionIndex >= state.quizData!.questions.length) {
          return ResultScreen(
            score: state.score,
            coins: state.coins,
            totalQuestions: state.quizData!.questions.length,
          );
        }

        final currentQuestion = state.quizData!.questions[state.currentQuestionIndex];

        return Stack(
          children: [
            Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.monetization_on,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${state.coins}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.stars,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${state.score}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: (state.currentQuestionIndex + 1) / state.quizData!.questions.length,
                              backgroundColor: Colors.white30,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Question ${state.currentQuestionIndex + 1}/${state.quizData!.questions.length}',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          currentQuestion.description,
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ...currentQuestion.options.map(
                                  (option) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 300),
                                      opacity: state.selectedAnswers.contains(option.id) ? 0.7 : 1.0,
                                      child: ElevatedButton(
                                        onPressed: state.selectedAnswers.contains(option.id)
                                            ? null
                                            : () {
                                                _showAnswerFeedback(option.isCorrect);
                                                context.read<QuizBloc>().add(
                                                      AnswerQuestionEvent(
                                                        state.currentQuestionIndex,
                                                        option.id,
                                                        option.isCorrect,
                                                      ),
                                                    );
                                                Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                    context.read<QuizBloc>().add(NextQuestionEvent());
                                                  },
                                                );
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _getOptionColor(
                                            context,
                                            option,
                                            state.selectedAnswers.contains(option.id),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                option.description,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: state.selectedAnswers.contains(option.id) ? Colors.white : null,
                                                    ),
                                              ),
                                            ),
                                            if (state.selectedAnswers.contains(option.id))
                                              Icon(
                                                option.isCorrect ? Icons.check_circle : Icons.cancel,
                                                color: option.isCorrect ? Colors.white : Colors.white,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_showFeedback)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showFeedback ? 0.2 : 0.0,
                child: Container(
                  color: _isCorrect == true ? Colors.green : Colors.red,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            if (_showFeedback)
              Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: _showFeedback ? 1.0 : 0.0,
                  child: Icon(
                    _isCorrect == true ? Icons.check_circle_outline : Icons.cancel_outlined,
                    size: 100,
                    color: _isCorrect == true ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Color _getOptionColor(BuildContext context, Option option, bool isSelected) {
    if (!isSelected) {
      return Theme.of(context).colorScheme.surface;
    }
    return option.isCorrect ? Colors.green : Colors.red;
  }
}
