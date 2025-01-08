import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trial/services/loginapi.dart'; // Import Dio

class ComplaintPage extends StatefulWidget {
  final String userId;

  const ComplaintPage({super.key, required this.userId}); 

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController _complaintController = TextEditingController();
  final Dio _dio = Dio(); // Create a Dio instance

  Future<void> _submitComplaint() async {
    final complaint = _complaintController.text.trim();

    if (complaint.isNotEmpty) {
      // Construct the API endpoint URL
      final String url = '$baseUrl/submitcomplaint'; // Replace with your API URL

      // Create the request body
      final Map<String, String> requestBody = {
        'complaint': complaint,
        'user_id': widget.userId.toString(), 
      };

      try {
        // Make the POST request using Dio
        final response = await _dio.post(
          url,
          data: requestBody,
          options: Options(
            headers: {'Content-Type': 'application/json'}, // Set headers
          ),
        );

        if (response.statusCode == 200) {
          // Handle success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Complaint submitted: $complaint")),
          );
          _complaintController.clear(); // Clear the text field after submission
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to submit complaint. Please try again.")),
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
        SnackBar(content: Text("Please enter your complaint.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Complaint"),
        backgroundColor: Colors.blue, // Changed to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "We value your complaints!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _complaintController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Your Complaint",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitComplaint,
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


