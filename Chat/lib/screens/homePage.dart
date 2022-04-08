import 'package:flutter/material.dart';
import 'package:projetb2c/screens/chatDetailPage.dart';
import 'package:projetb2c/screens/chatPage.dart';
import 'package:projetb2c/widgets/conversationList.dart';

class HomePage extends StatelessWidget {
  PageController controller = PageController();
  @override


  Widget build(BuildContext context) {
    EdgeInsets a2; EdgeInsetsDirectional a;
    return Scaffold(
      body: controllers(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          controller.animateToPage(value, duration: Duration(seconds: 1), curve: Curves.ease);
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),

        ],
      ),
    );

  }
  Widget controllers() {

    return PageView(
      controller: controller,
      children: [
        ChatPage(),
        ConversationList(messageText: 'ok', isMessageRead: true,name:'ok', imageUrl: ',rnr', time: '0',),

      ],

    );

  }

}








