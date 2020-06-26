//Pantalla de espera antes de ser redirigido a un juego
import 'dart:async';
import 'dart:math';
import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Espera extends StatefulWidget {
  Size size;
  int tipo;
  @override
  _EsperaState createState() => _EsperaState(size,tipo);
  Espera(this.size,this.tipo);
}

class _EsperaState extends State<Espera> {
  //Elementos de la pantalla de espera
  Size size;
  int tipo;
  String idSala="";
  List<String> consejos=[
    "Piensa bien antes de realizar tu jugada",
    "Los dados son muy sensibles ten cuidado.",
    "Recuerda que puedes ganar de varias formas.",
    "Tu oponente puede ser mas inteligente que tu.",
    "No te apresures. Paciencia!"];


  _EsperaState(this.size,this.tipo);

  //Funcion que llama al servidor para buscar una nueva partida
   espera()async {
     String idSala2=await FuncionesJuegos().buscarPartida(tipo) ;
     setState(() {
       idSala=idSala2;
     });
  }
  //Variable que determina cual consejo mostrar
  int indexcon=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Random para elegir cual consejo mostrar
   setState(() {
     indexcon=Random().nextInt(5);
   });
    espera();
  }
  @override
  Widget build(BuildContext context) {
    //Stream Builder para poder determinar si la sala se completo y esta activa o encendida
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: StreamBuilder(
        //se pregunta si ya se tiene el ida de sala para buscar en la base de datos
        stream: idSala!=""?Firestore.instance.collection("Salas").document(idSala).snapshots():null,
        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
          //Se verifica se llego algun dato
          if(snapshot.hasData&&idSala!=""){
            //si se ve que en nuestra base de datos la partida esta activa
            //se le redirige al jugador a la pantalla de juego
            //mediante un CallBack para utilizarlo en el StreamBuilder
            if(snapshot.data.exists&&snapshot.data.data['encendido'])
            {
              myCallback(()async {
                FirebaseUser d=await FirebaseAuth.instance.currentUser();
                Navigator.pushNamedAndRemoveUntil(context, "/mainGame",ModalRoute.withName("/"),arguments: [size,idSala,snapshot.data.data['tipo'],d.uid]);
              });
            }
          }
          //Scaffold Principal donde se muestra la pantalla de muestra con todos sus
          //atributos
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

      )
    );
  }
  //Funcion que sirve para poder llamar a una funcion o setstate en un stream builder
  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
