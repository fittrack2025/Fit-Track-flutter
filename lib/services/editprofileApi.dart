// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:trial/profile.dart';
// import 'package:trial/services/getProfile.dart';

// final Dio _dio = Dio();

// Future<bool> editUserProfile(String baseUrl, String userId, Map<String, dynamic> profileData,context) async {
//   try {
//     final String endpoint = '$baseUrl/EditProfileAPI/$userId'; // Construct the endpoint URL

//     // Log the request
//     print('Sending edit profile request to: $endpoint');
//     print('Profile Data: $profileData');

//     // Make the API call
//     final response = await _dio.put(
//       endpoint,
//       data: profileData,
//       options: Options(
//         headers: {'Content-Type': 'application/json'}, // Adjust headers if required
//       ),
//     );

//     if (response.statusCode == 200) {
//       print('Profile updated successfully: ${response.data}');
//       Navigator.pop(context);
//       Navigator.pop(context);
//        await getUserProfile();
//               // Navigate to the ProfilePage
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()),
//               );
      
//       return true; // Indicating success
//     } else if (response.statusCode == 404) {
//       print('Error 404: Endpoint not found or invalid userId.');
//       return false;
//     } else {
//       print('Failed with status code: ${response.statusCode}');
//       return false;
//     }
//   } catch (e) {
//     print('Error editing user profile: $e');
//     return false; // Return false on failure
//   }
// }
