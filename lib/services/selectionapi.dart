import 'package:dio/dio.dart';


  final Dio _dio = Dio();


  Future<Map<String, dynamic>> getDietitionsAndTrainers() async {
    try {
      final response = await _dio.get('/view-dietitions-trainers');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to fetch data',
        };
      }
    } on DioError catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'An error occurred',
      };
    }
  }

