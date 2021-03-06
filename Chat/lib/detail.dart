import 'package:flutter/material.dart';
import 'package:projetb2c/model/Utilisateur.dart';

class detail extends StatefulWidget{
  Utilisateur user;
  detail({required Utilisateur this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }

}

class detailState extends State<detail>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.prenom}  ${widget.user.nom!}"),
        centerTitle: true,
      ),
      body: bodyPage(),
    );
  }
  Widget bodyPage(){
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: (widget.user.avatar==null)
                  ?const NetworkImage("https://64.media.tumblr.com/64f2da4505e390184beb862190c482ed/tumblr_pza4kubFAH1xqjbg4o1_r2_500.png")
                  :NetworkImage(widget.user.avatar!)
            )
          ),
        ),
        Text("${widget.user.prenom}  ${widget.user.nom}"),
        (widget.user.birthday==null)?Container():Text(widget.user.birthday.toString())
      ],
    );
  }
}