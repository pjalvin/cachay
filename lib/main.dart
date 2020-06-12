import 'package:cachay/menu.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(

      ),
      title: 'Cachay',

      home: MainCacho()
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
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SplashScreen(
      backgroundColor: color2,
      photoSize: size.width*0.2,
      image: Image.asset("assets/logo.png",),
      seconds: 3,
      loaderColor: color3,

      navigateAfterSeconds: Menu()
    );
  }
}

