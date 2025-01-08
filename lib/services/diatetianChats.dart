import 'package:dio/dio.dart';
import 'package:trial/services/loginapi.dart';


  final Dio _dio = Dio();

  // Replace with your API endpoint
  // final String baseUrl = 'https://api.example.com/user/profiles'; // Updated endpoint for multiple profiles

  Future<List<Map<String, dynamic>>> getdiatetianChats(sendId,reciveId) async {
    try {
      final response = await _dio.get('$baseUrl/chat/$sendId/$reciveId',); // Make the GET request

      if (response.statusCode == 200) {
        print(response.data);
        // Return the JSON response as a List<Map<String, dynamic>>
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        print('Failed to load user profiles: ${response.statusCode}');
        return []; // Return an empty list if the response is not successful
      }
    } catch (e) {
      print('Error fetching user profiles: $e');
      return []; // Handle any errors that occur during the request
    }
  }

   Future<void> senddiatetianChats(sendId,reciveId,msg) async {
    try {
      final response = await _dio.post('$baseUrl/chat/$sendId/$reciveId',data: {'message':msg}); // Make the GET request

      if (response.statusCode == 201) {
        print(response.data);
        // Return the JSON response as a List<Map<String, dynamic>>
       print('success');
      } else {
        print('Failed to load user profiles: ${response.statusCode}');
        return ; // Return an empty list if the response is not successful
      }
    } catch (e) {
      print('Error fetching user profiles: $e');
      return ; // Handle any errors that occur during the request
    }
  }


