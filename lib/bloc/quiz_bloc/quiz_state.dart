part of 'quiz_bloc.dart';

class QuizState {
  final GetQuizData? quizData;
  final int currentQuestionIndex;
  final List<int> selectedAnswers;
  final int score;
  final int coins;
  final UserProgress userProgress;
  final bool isLoading;
  final String? error;

  QuizState({
    this.quizData,
    this.currentQuestionIndex = 0,
    this.selectedAnswers = const [],
    this.score = 0,
    this.coins = 0,
    required this.userProgress,
    this.isLoading = false,
    this.error,
  });

  QuizState copyWith({
    GetQuizData? quizData,
    int? currentQuestionIndex,
    List<int>? selectedAnswers,
    int? score,
    int? coins,
    UserProgress? userProgress,
    bool? isLoading,
    String? error,
  }) {
    return QuizState(
      quizData: quizData ?? this.quizData,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      score: score ?? this.score,
      coins: coins ?? this.coins,
      userProgress: userProgress ?? this.userProgress,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
