import 'package:flutter/material.dart';

void main() => runApp(ChatSwitchApp());

class ChatSwitchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatWithDietitianTrainer(),
    );
  }
}

class ChatWithDietitianTrainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat with Experts'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Dietitian'),
              Tab(text: 'Trainer'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChatPage(title: 'Dietitian'),
            ChatPage(title: 'Trainer'),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key? key, required this.title}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_messages[index]),
                leading: CircleAvatar(
                  child: Text(widget.title[0]),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _sendMessage,
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
