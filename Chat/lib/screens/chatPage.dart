import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetb2c/MyWidgets/menuDrawer.dart';
import 'package:projetb2c/model/Utilisateur.dart';
import 'package:projetb2c/screens/chatDetailPage.dart';

import '../functions/FirestoreHelper.dart';
import '../model/chatUsersModel.dart';
import '../widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        title: Text("Utilisateurs"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),


      body: bodyPage(),


    );
  }

  Widget bodyPage(){
    return


      Column(

        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirestoreHelper().fire_user.snapshots(),

              builder: (builder, snapshots) {
                if (!snapshots.hasData) {
                  return CircularProgressIndicator();
                }
                else {
                  List document = snapshots.data!.docs;
                  return
                    ListView.builder(
                      itemCount: document.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Utilisateur users = Utilisateur(document[index]);
                        return
                          Text(users.prenom);

                      },
                    );


                }
              }
          ),


          InkWell( // permet de rendre les information plicables
            onTap: () {
              print("J'ai cliqué dessus");
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ChatDetailPage();
                  }
              ));
            },
            child: Text("Test",
              style: TextStyle(color: Colors.red),),
          )
        ],
      );

  }


}