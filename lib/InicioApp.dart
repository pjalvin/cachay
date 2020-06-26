//Esta es mi pantalla de carga donde verifica el login
import 'package:cachay/User/Auth.dart';
import 'package:cachay/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Size size = MediaQuery
        .of(context)
        .size;
    return
      Scaffold(
        backgroundColor: color2,
        body: ListView(
          children: <Widget>[
            Container(
                height: size.height * 0.5,
                width: size.width,
                child: Center(
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                    height: size.width * 0.4,
                    width: size.width * 0.4,),
                )

            ),
            Container(
                height: size.height * 0.5,
                width: size.width,
                child: Center(
                    child: Container(
                      height: 10,
                      width: size.width * 0.7,
                      child: LinearProgressIndicator(
                        backgroundColor: color3,

                        valueColor: new AlwaysStoppedAnimation<Color>(color5),
                      ),
                    )
                )
            )
          ],
        ),
      );
  }
}