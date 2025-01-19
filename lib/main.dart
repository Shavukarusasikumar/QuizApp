import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_app/theme.dart';
import 'package:quiz_app/views/welcome_view.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(
          create: (context) => QuizBloc(),
        ),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        home: WelcomeScreen(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
