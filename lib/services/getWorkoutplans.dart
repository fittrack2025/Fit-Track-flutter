// import 'package:dio/dio.dart';

// final Dio _dio = Dio();

// Future<List<Map<String, dynamic>>> getWorkPlansApi() async {
//   try {
//     final response = await _dio.get('/Workout status');
// print(response.data);
//     if (response.statusCode == 200) {
//       // Assuming response.data is a list of maps
//       return List<Map<String, dynamic>>.from(response.data);
//     } else {
//       throw Exception(response.data['message'] ?? 'Failed to fetch data');
//     }
//   } on DioError catch (e) {
//     // If DioError occurs, handle it gracefully and return an empty list
//     return Future.error(
//       e.response?.data['message'] ?? 'An error occurred',
//     );
//   }
// }
