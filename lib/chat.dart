import 'package:flutter/material.dart';
import 'package:trial/services/diatetianChats.dart';
import 'package:trial/services/getProfile.dart';
import 'package:trial/services/loginapi.dart';



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
          physics: NeverScrollableScrollPhysics(),
          children: [
            ChatPage(title: 'Dietitian',sendId:loginId ,reciveId: profiledatacore['dietition_login_id'],),
            ChatPage(title: 'Trainer',sendId: loginId,reciveId:profiledatacore['trainer_login_id'] ,),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final sendId;
  final reciveId;
  final String title;
  const ChatPage({Key? key, required this.title,required this.sendId,required this.reciveId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  void _sendMessage()async {
    if (_messageController.text.isNotEmpty) {
      await senddiatetianChats(widget.sendId,widget. reciveId, _messageController.text);
        _messages=await  getdiatetianChats(widget.sendId,widget. reciveId);
      setState(() {
   
        _messageController.clear();
      });
    }
  }
  @override
  void initState() {
   ggetdata();
    super.initState();
  }

  void ggetdata()async{
     _messages=await  getdiatetianChats(widget.sendId,widget. reciveId);
     setState(() {
       
     });
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
                title: Text(_messages[index]['message']),
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


// 