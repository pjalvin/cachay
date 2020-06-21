import 'dart:async';
import 'dart:math';

import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Espera extends StatefulWidget {
  Size size;
  @override
  _EsperaState createState() => _EsperaState(size);
  Espera(this.size);
}

class _EsperaState extends State<Espera> {
  Size size;
  String idSala="";
  List<String> consejos=[
    "Piensa bien antes de realizar tu jugada",
    "Los dados son muy sensibles ten cuidado.",
    "Recuerda que puedes ganar de varias formas.",
    "Tu oponente pude ser mas inteligente que tu.",
    "No te apresures. Paciencia!"];
  _EsperaState(this.size);
   espera()async {
     String idSala2=await FuncionesJuegos().buscarPartida(2) ;
     setState(() {
       idSala=idSala2;
     });
  }
  int indexcon=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   setState(() {
     indexcon=Random().nextInt(5);
   });
    espera();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: idSala!=""?Firestore.instance.collection("Salas").document(idSala).snapshots():null,
      builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasData&&idSala!=""){
          if(snapshot.data.exists&&snapshot.data.data['encendido']){
            myCallback(()async {
              FirebaseUser d=await FirebaseAuth.instance.currentUser();
              Navigator.pushNamedAndRemoveUntil(context, "/mainGame",ModalRoute.withName("/"),arguments: [size,idSala,snapshot.data.data['tipo'],d.uid]);
            });
          }
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: color7.withOpacity(0.7),
                image: DecorationImage(
                    image: AssetImage("assets/recursos/dados4.jpg"),
                    fit: BoxFit.cover
                )
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  color: color7.withOpacity(0.6),
                ),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(color6.withOpacity(0.8)),

                    backgroundColor: color7.withOpacity(0.5),
                  ),
                ),
                Align(
                  alignment: Alignment(0,0.9),

                  child: Container(
                    padding: EdgeInsets.all(size.width*0.05),
                    color: color7.withOpacity(0.8),
                    child: Text(consejos[indexcon],textAlign: TextAlign.center,style: TextStyle(color: color6,fontSize: size.width*0.05,fontFamily: 'CenturyGothic'),),
                      
                  ) ),
                Align(
                    alignment: Alignment(0,-0.7),

                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.all(size.width*0.05),
                      color: color5.withOpacity(0.7),
                      child: Text("Buscando Partida..",textAlign: TextAlign.center,style: TextStyle(color: color7,fontSize: size.width*0.06,fontFamily: 'CenturyGothic',fontWeight: FontWeight.w500),),

                    ) )
              ],
            )
          ),
        );
      },

    );
  }
  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
