import 'package:dio/dio.dart';
import 'package:trial/services/loginapi.dart';


  final Dio _dio = Dio();

  // Replace with your API endpoint


  Future<Map<String, dynamic>> getUserProfile() async {
  try {
    final response = await _dio.get('$baseUrl/ViewProfileAPI/$loginId');
    if (response.statusCode == 200) {
      print('API Response: ${response.data}');
      return response.data as Map<String, dynamic>;
    } else if (response.statusCode == 404) {
      print('Error 404: Endpoint not found or invalid loginId.');
      return {};
    } else {
      print('Failed with status code: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Error fetching user profile: $e');
    return {};
  }
}



