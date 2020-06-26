import 'package:cachay/User/Profile.dart';
import 'package:cachay/game/componentes/Tablero1/Panel.dart';
import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Terminado extends StatelessWidget {
  double width,height;
  String turno,id,ganador;
  Size size;
  Terminado(this.width,this.height,this.ganador,this.turno,this.id,this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        color: color7.withOpacity(0.9),
        child: Column(
          children: <Widget>[
            Container(
                height: height*0.25,
                child: Center(
                  child: Text(turno==id?"Ganador":"Perdedor",style: TextStyle(color: color6,fontSize: size.width*0.18,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold),),

                )
            ),

            Container(
              height: height*0.1,
              color: turno==id?Color(0xff0A3226).withOpacity(0.8):color1.withOpacity(0.5),
              child: Center(
                  child: Text(turno==id?ganador:"Ganó "+ganador,style: TextStyle(color: color6,fontSize: size.width*0.09,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold),)
              ),
            ),
            Container(
                height: height*0.25,
                padding: EdgeInsets.all(height*0.02),
                child: Center(
                  child: Image.asset("assets/logo.png"),
                )
            ),
            Container(
                height: height*0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: height*0.2,
                      decoration: BoxDecoration(
                          color: color7.withOpacity(0.3),
                          border: Border(top:BorderSide(color: color5,width: 0.4),bottom: BorderSide(color: color5,width: 0.4))
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: height*0.2,
                            width: width*0.6,
                            child: Center(
                              child: Text(turno==id?"Recibiste\n"+"200"+" XP":"Recibiste\n"+"20"+" XP",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: color5,
                                  fontSize: size.width*0.08,
                                  fontFamily: 'CenturyGothic',),),

                            ),
                          ),
                          Panel().recurso2(height*0.15, width*0.3, "assets/recursos/monedas2.png", "", 0.5),
                        ],
                      ),
                    ),
                    Divider(
                      height: height*0.025,
                      color: Colors.transparent,
                    ),
                    Container(
                      height: height*0.04,
                      width: width*0.4,
                      child: MaterialButton(
                          elevation: 0,
                          color: color1.withOpacity(0.5),
                          onPressed: ()async{
                            FirebaseUser user=await FirebaseAuth.instance.currentUser();
                            var snap=await Firestore.instance.collection("Usuarios").document(id).get();
                            Profile prof=new Profile(user.email, snap.data["Nombre"], snap.data["oro"],
                                snap.data["diamantes"],snap.data["cambioN"] , snap.data["xp"]);
                            Navigator.pushNamedAndRemoveUntil(context,"/menu", ModalRoute.withName("/menu"),arguments: prof);
                          },
                          child: Center(
                            child: Text('Aceptar',
                              style:
                              TextStyle(
                                color: color6,
                                fontSize: height*0.025,
                                fontFamily: 'CenturyGothic',),),
                          )
                      ),
                    )
                  ],
                )
            )
          ],
        )
    );;
  }
}
