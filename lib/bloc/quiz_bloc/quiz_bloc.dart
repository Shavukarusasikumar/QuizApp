import 'package:bloc/bloc.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/models/user_progress.dart';
import 'package:quiz_app/repositories/quiz_repository.dart';
import 'package:quiz_app/services/storage_service.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState(userProgress: UserProgress())) {
    on<LoadQuizEvent>(onLoadQuiz);
    on<AnswerQuestionEvent>(onAnswerQuestion);
    on<NextQuestionEvent>(onNextQuestion);
    on<ResetQuizEvent>(onResetQuiz);
    on<LoadUserProgressEvent>(onLoadUserProgress);
    add(LoadUserProgressEvent());
  }

  QuizRepository repository = QuizRepository();
  Future<void> onLoadUserProgress(LoadUserProgressEvent event, Emitter<QuizState> emit) async {
    try {
      final progress = await StorageService.loadProgress();
      emit(state.copyWith(userProgress: progress));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> onLoadQuiz(LoadQuizEvent event, Emitter<QuizState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final quizData = await repository.fetchQuizData();
      emit(state.copyWith(
        quizData: quizData,
        isLoading: false,
        currentQuestionIndex: 0,
        selectedAnswers: [],
        score: 0,
        coins: 0,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit) async {
    final newSelectedAnswers = [...state.selectedAnswers, event.optionId];
    final newScore = event.isCorrect ? state.score + 10 : state.score;
    final newCoins = event.isCorrect ? state.coins + 5 : state.coins;

    final currentProgress = state.userProgress;
    final newProgress = currentProgress.copyWith(
      highScore: newScore > currentProgress.highScore ? newScore : currentProgress.highScore,
      totalCoins: currentProgress.totalCoins + (event.isCorrect ? 5 : 0),
    );

    await StorageService.saveProgress(newProgress);

    emit(state.copyWith(
      selectedAnswers: newSelectedAnswers,
      score: newScore,
      coins: newCoins,
      userProgress: newProgress,
    ));
  }

  void onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (state.quizData != null) {
      emit(state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      ));
    }
  }

  void onResetQuiz(ResetQuizEvent event, Emitter<QuizState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final quizData = await repository.fetchQuizData();
      final currentProgress = state.userProgress;
      final newProgress = currentProgress.copyWith(
        gamesPlayed: currentProgress.gamesPlayed + 1,
      );

      await StorageService.saveProgress(newProgress);

      emit(state.copyWith(
        quizData: quizData,
        isLoading: false,
        currentQuestionIndex: 0,
        selectedAnswers: [],
        score: 0,
        coins: 0,
        userProgress: newProgress,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }
}
