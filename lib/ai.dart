import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // List to store messages
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool _showSuggestions = false; // Track whether to show suggestions

  // Sample suggestions
  final List<String> _suggestions = [
    "best fibre foods",
    "Tell me a fitness fact.",
    "Suggest some high protein foods?",
    "How do I improve my physique?",
    "How many water should i drink a day?"
  ];

  Future<String> _sendToGemini(String userMessage) async {
    try {
      final response = await Gemini.instance.prompt(parts: [
        Part.text(userMessage), // Use the user message passed to the function
      ]);

      if (response != null && response.output != null) {
        print(response.output); // Print the output for debugging
        return response.output!;
      } else {
        return 'Error: No output received from the API.';
      }
    } catch (e) {
      print('Error: $e'); // Log any errors for debugging
      return 'Error: Unable to connect to Gemini API. $e'; // Return a user-friendly error message
    }
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "message": text}); // User message
      _controller.clear();
      _isLoading = true;
    });

    final reply = await _sendToGemini(text); // Send message to Gemini API

    setState(() {
      _messages.add({"sender": "gemini", "message": reply}); // Gemini's reply
      _isLoading = false;
    });

    // Auto-scroll to the latest message
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // Delay the scroll to ensure the new message is rendered
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _insertSuggestion(String suggestion) {
    _controller.text = suggestion; // Insert the suggestion into the TextField
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: suggestion.length)); // Move cursor to the end
    setState(() {
      _showSuggestions = false; // Hide suggestions after inserting
    });
  }

  void _toggleSuggestions() {
    setState(() {
      _showSuggestions = !_showSuggestions; // Toggle the visibility of suggestions
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Gemini'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Set the scroll controller
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";

                return Container(
                  alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: isUser ? Radius.circular(0) : Radius.circular(12),
                        bottomRight: isUser ? Radius.circular(12) : Radius.circular(0),
                      ),
                    ),
                    child: Text(
                      message["message"]!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showSuggestions ? Icons.close : Icons.list,
                          color: Colors.blue,
                        ),
                        onPressed: _toggleSuggestions,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          // Show suggestions if the toggle is true
          if (_showSuggestions)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: _suggestions.map((suggestion) {
                  return ElevatedButton(
                    onPressed: () => _insertSuggestion(suggestion),
                    child: Text(suggestion),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
