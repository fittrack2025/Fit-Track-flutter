import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trial/homepage.dart';
import 'package:trial/services/getProfile.dart';

final Dio _dio = Dio();
String baseUrl = 'http://192.168.1.196:5000';

String? loginId;

Future<Map<String, dynamic>> loginapi(String email, String password,context) async {
  try {
    final response = await _dio.post(
      '$baseUrl/LoginPage',
      data: {
        'username': email,
        'password': password,
      },
    );
    print(response.data);

    if (response.statusCode == 200&& response.data['message']=='success') {
      loginId=response.data['login_id'].toString();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctxt)=>HomePage()));
    await  getUserProfile();
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
