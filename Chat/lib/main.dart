import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetb2c/screens/homePage.dart';
import 'package:projetb2c/functions/FirestoreHelper.dart';
import 'package:projetb2c/dashboard.dart';
import 'package:projetb2c/register.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  );
}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String mail="";
  String password ="";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Chat")),
      ),

    );
  }


  popUp(){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Erreur !!!"),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("OK")
              )
            ],
          );
        }
    );
  }

  Widget bodyPage(){
    return Column(

      children: [
        //Afficher un logo
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage("https://64.media.tumblr.com/64f2da4505e390184beb862190c482ed/tumblr_pza4kubFAH1xqjbg4o1_r2_500.png"),
            ),

          ),
        ),
        SizedBox(height: 20,),

        //Utilisateur tape son adresse mail
        TextField(
          onChanged: (value){
            setState(() {
              mail = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Entrer votre adresse mail",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
        ),
        SizedBox(height: 20,),
        //Utilisateur
        //tape son mot de passe
        TextField(
          onChanged: (value){
            setState(() {
              password = value;
            });
          },
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Entrer votre mot de passe",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )
          ),
        ),
        SizedBox(height: 20,),
        //Bouton de connexion
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            )
          ),
            onPressed: (){

              print("Je  suis connecté");
              FirestoreHelper().Connect(mail: mail, password: password).then((value){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return dashBoard();
                    }
                ));
              }).catchError((error){
                popUp();
              });
            },
            child: Text("Connexion")
        ),
        SizedBox(height: 20,),
        // Lien vers une page Inscription
        InkWell(
          onTap: (){
            print("J'ai appuyé sur l'inscription");
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return register();
                }
            ));
          },
          child: Text("Inscription",style: TextStyle(color: Colors.blue),),
        )


      ],

    );


  }

}


