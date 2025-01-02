import 'package:dio/dio.dart';

final Dio _dio = Dio();
String baseUrl = 'http://192.168.27.16:5000';

String? loginId;

Future<Map<String, dynamic>> loginapi(String email, String password) async {
  try {
    final response = await _dio.post(
      '$baseUrl/LoginPage',
      data: {
        'username': email,
        'password': password,
      },
    );
    print(response.data);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'data': response.data,
      };
    } else {
      return {
        'success': false,
        'message': response.data['message'] ?? 'Login failed',
      };
    }
  } on DioError catch (e) {
    return {
      'success': false,
      
    };
  }
}
