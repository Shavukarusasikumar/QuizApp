import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/services/api_service.dart';

class QuizRepository {
  final ApiService _apiService = ApiService();

  Future<GetQuizData> fetchQuizData() async {
    try {
      final data = await _apiService.getRequest();
      return GetQuizData.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch quiz data: $e');
    }
  }
}
