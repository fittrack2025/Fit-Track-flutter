import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio

class FeedbackPage extends StatefulWidget {
  final String userId; 

  // Modify the constructor to accept userId
  FeedbackPage({required this.userId});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final Dio _dio = Dio(); // Create a Dio instance

  Future<void> _submitFeedback() async {
    final feedback = _feedbackController.text.trim();

    if (feedback.isNotEmpty) {
      
      final String url = 'http://192.168.1.196:5000/submitfeedback'; 

      
      final Map<String, String> requestBody = {
        'feedback': feedback,
        'user_id': widget.userId.toString(), 
      };

      try {
        
        final response = await _dio.post(
          url,
          data: requestBody,
          options: Options(
            headers: {'Content-Type': 'application/json'}, 
          ),
        );

        if (response.statusCode == 200 || response.statusCode==201) {
          // Handle success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Feedback submitted")),
          );
          _feedbackController.clear(); // Clear the text field after submission
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to submit feedback. Please try again.")),
          );
        }
      } on DioError catch (error) {
        // Handle Dio exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: ${error.message}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your feedback.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Feedback"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "We value your feedback!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Your Feedback",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


