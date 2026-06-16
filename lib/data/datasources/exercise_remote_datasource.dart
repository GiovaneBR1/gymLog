import 'package:dio/dio.dart';
import '../models/exercise_model.dart';

class ExerciseRemoteDataSource {
  final Dio _dio;

  static const String _apiKey =
      'E995i7uyFEtMWqIdai8vhEi1PDcdH8mJ8vIfwW4h';

  static const String _baseUrl =
      'https://api.api-ninjas.com/v1/exercises';

  ExerciseRemoteDataSource(this._dio);

  Future<List<ExerciseModel>> fetchByMuscle(String muscle) async {
    print('========================');
    print('MUSCLE ENVIADO: $muscle');

    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'muscle': muscle.toLowerCase(),
        },
        options: Options(
          headers: {
            'X-Api-Key': _apiKey,
          },
        ),
      );

      print('STATUS: ${response.statusCode}');
      print('TOTAL EXERCICIOS: ${(response.data as List).length}');

      final List data = response.data as List;

      return data
          .map((e) => ExerciseModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      print('========================');
      print('ERRO API');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('URL: ${e.requestOptions.uri}');
      print('QUERY: ${e.requestOptions.queryParameters}');
      print('========================');

      return [];
    } catch (e) {
      print('ERRO INESPERADO: $e');
      return [];
    }
  }
}