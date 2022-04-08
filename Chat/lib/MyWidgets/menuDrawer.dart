import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetb2c/functions/FirestoreHelper.dart';
import 'package:projetb2c/model/Utilisateur.dart';
import 'package:file_picker/file_picker.dart';

class myDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myDrawerState();
  }

}

class myDrawerState extends State<myDrawer>{
  late Utilisateur myProfil;
  late String uid;
  late Uint8List? byteData;
  late String fileName;
  late String urlImage;

  PopImage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isIOS){
            return CupertinoAlertDialog(
              title: Text("Souhaitez utilser cette photo comme profil ?"),
              content: Image.memory(byteData!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
            },
                    child: Text("Annuler")
                ),

                ElevatedButton(
                    onPressed: (){
                      //enregitrer notre image dans la base de donnée
                },
                    child: Text("Enregitrement)"
                ),
                )

              ],
            );
          }
          else
            {
              return AlertDialog(
                title: Text("Souhaitez utilser cette photo comme profil ?"),
                content: Image.memory(byteData!),
                actions: [

                ],

              );
            }

        }
    );
  }

  importerImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if(result !=null){
      setState(() {
        byteData = result.files.first.bytes;
        fileName = result.files.first.name;
      });
      PopImage();
    }



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FirestoreHelper().getIdentifiant().then((String identifiant){
      setState(() {
        uid = identifiant;
        FirestoreHelper().getUtilisateur(uid).then((Utilisateur user){
          setState(() {
            myProfil = user;
          });
        });
      });
    });




    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width/2,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            InkWell(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: (myProfil.avatar == null)?NetworkImage("https://64.media.tumblr.com/64f2da4505e390184beb862190c482ed/tumblr_pza4kubFAH1xqjbg4o1_r2_500.png"):NetworkImage(myProfil.avatar!)
                    )
                ),
              ),
              onTap: (){
                //Afficher nos photos
                importerImage();

              },
            ),

            SizedBox(height: 20,),
            Text("${myProfil.prenom} ${myProfil.nom}"),
            SizedBox(height: 20,),
            Text(myProfil.mail),



          ],
        ),
      )
    );

  }









}