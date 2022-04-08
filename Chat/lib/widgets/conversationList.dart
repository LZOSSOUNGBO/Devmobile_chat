import 'package:flutter/material.dart';

import '../screens/chatDetailPage.dart';

class ConversationList extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList({required this.name,required this.messageText,required this.imageUrl,required this.time,required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatDetailPage();
          }));
        });
  }


  }
