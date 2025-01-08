// import 'package:dio/dio.dart';
// import 'package:trial/services/loginapi.dart';

//   final Dio _dio = Dio();

//   // Replace with your API endpoint
//   // final String baseUrl = 'https://api.example.com/user/profiles'; // Updated endpoint for multiple profiles

//   Future<List<Map<String, dynamic>>> gettrainerChats() async {
//     try {
//       final response = await _dio.get('$baseUrl/ffgjh'); // Make the GET request

//       if (response.statusCode == 200) {
//         // Return the JSON response as a List<Map<String, dynamic>>
//         return List<Map<String, dynamic>>.from(response.data);
//       } else {
//         print('Failed to load user profiles: ${response.statusCode}');
//         return []; // Return an empty list if the response is not successful
//       }
//     } catch (e) {
//       print('Error fetching user profiles: $e');
//       return []; // Handle any errors that occur during the request
//     }
//   }

//    Future<void> sendtrainerChats() async {
//     try {
//       final response = await _dio.get('$baseUrl/ffgjh'); // Make the GET request

//       if (response.statusCode == 200) {
//         // Return the JSON response as a List<Map<String, dynamic>>
//        print('success');
//       } else {
//         print('Failed to load user profiles: ${response.statusCode}');
//         return ; // Return an empty list if the response is not successful
//       }
//     } catch (e) {
//       print('Error fetching user profiles: $e');
//       return ; // Handle any errors that occur during the request
//     }
//   }


