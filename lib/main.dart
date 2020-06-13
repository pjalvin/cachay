import 'package:cachay/User/Auth.dart';
import 'package:cachay/alerts/Alerts.dart';
import 'package:cachay/game/mainGame.dart';
import 'package:cachay/menu.dart';
import 'package:cachay/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cachay',
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
final color1= Color(int.parse("FC2D2D",radix: 16)).withOpacity(1);
final color2= Color(int.parse("32373B",radix: 16)).withOpacity(1.0);
final color3= Color(int.parse("4A5859",radix: 16)).withOpacity(1.0);
final color4= Color(int.parse("F4D6CC",radix: 16)).withOpacity(1.0);
final color5= Color(int.parse("F4B860",radix: 16)).withOpacity(1.0);
final color6= Colors.white;
final color7= Colors.black;
class MainCacho extends StatefulWidget {
  @override
  _MainCachoState createState() => _MainCachoState();
}

class _MainCachoState extends State<MainCacho> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //AuthUser().cerrarSesion(context);
    AuthUser().verinicio(context);
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return /*SplashScreen(
      backgroundColor: color2,
      photoSize: size.width*0.2,
      image: Image.asset("assets/logo.png",),
      seconds: 60,
      loaderColor: color3,

      navigateAfterSeconds: MyApp()
    );*/
    Scaffold(
      backgroundColor: color2,
      body: ListView(
        children: <Widget>[
          Container(
            height: size.height*0.5,
            width: size.width,
            child:Center(
              child: Image(image:AssetImage("assets/logo.png"),height: size.width*0.4,width: size.width*0.4,),
            )

          ),
          Container(
            height: size.height*0.5,
            width: size.width*0.7,
            child:Center(
              child: LinearProgressIndicator(
                  backgroundColor: color3,

                  valueColor: new AlwaysStoppedAnimation<Color>(color5),
              )
              )
          )
        ],
      ),
    );
  }






}

