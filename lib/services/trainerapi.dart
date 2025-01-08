import 'package:dio/dio.dart';
import 'package:trial/services/loginapi.dart';

final Dio _dio = Dio(
 
);

Future<List<dynamic>> trainerApi() async {
  try {
    final response = await _dio.get('$baseUrl/ViewTrainerAPI');
    
    if (response.statusCode == 200 && response.data != null) {
      // Ensure data is returned in a list format
      if (response.data is List) {
        return response.data;
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception(
          'Failed to fetch trainers. Status code: ${response.statusCode}');
    }
  } on DioError catch (dioError) {
    // Handle Dio-specific errors
    if (dioError.response != null) {
      throw Exception(
          "Dio error occurred: ${dioError.response?.statusCode} - ${dioError.response?.statusMessage}");
    } else {
      throw Exception("Network error: ${dioError.message}");
    }
  } catch (e) {
    // Handle generic errors
    throw Exception("Error fetching trainers: $e");
  }
}
