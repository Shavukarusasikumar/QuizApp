part of 'quiz_bloc.dart';

abstract class QuizEvent {}

class LoadQuizEvent extends QuizEvent {}

class AnswerQuestionEvent extends QuizEvent {
  final int questionIndex;
  final int optionId;
  final bool isCorrect;

  AnswerQuestionEvent(this.questionIndex, this.optionId, this.isCorrect);
}

class NextQuestionEvent extends QuizEvent {}

class ResetQuizEvent extends QuizEvent {}

class LoadUserProgressEvent extends QuizEvent {}
