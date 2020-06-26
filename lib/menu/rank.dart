//En esta clase se muestra el ranking de los jugadores dependiendo de su xp
//Aqui te avisa en que puesto estas y cual es tu xp
//Ademas igual te marca en la lista en que posicion estas

import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  int exp=252;
  int puesto=234;
  FirebaseUser user;
  List<List<String>> resultados=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recibirDatos();
  }
  //WIdget principal donde se carga los datos y su componentes
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double heigthpage=size.height-50;
    return Container(
        color: Colors.white,
        child:Column(
          children: <Widget>[
            Container(
                width: size.width,
                color: color2,
                height: heigthpage*0.35,
                child:Column(
                  children: <Widget>[
                    Container(
                      height: heigthpage*0.35,
                      padding: EdgeInsets.all(heigthpage*0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: color5,

                            radius: heigthpage*0.11,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Puesto",style: TextStyle(color: color3,fontSize: heigthpage*0.03,fontFamily: 'CenturyGothic'),),
                                  Text(puesto.toString(),style: TextStyle(color: color2,fontSize: heigthpage*0.07,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: heigthpage*0.01,
                            color: Colors.transparent,
                          ),
                          Container(
                            child:
                            Text(exp.toString()+" XP",style: TextStyle(color: color6,fontSize: heigthpage*0.03),),
                          )
                        ],
                      )
                    ),
                  ],
                )
            ),

            Container(
                height: heigthpage*0.65,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      color: color3,
                      child:Row(
                    children: <Widget>[
                          Container(
                              color:color6.withOpacity(0.8),
                              height: 40,
                              width: size.width*0.1,
                              child:Center(
                                child: Text(("N°").toString(),style: TextStyle(fontFamily: 'CenturyGothic'),),
                              )
                          ),
                          Container(
                              color:color6.withOpacity(0.8),
                              height: 40,
                              width: size.width*0.6,
                              child:Center(
                                child: Text(("Nombre").toString(),style: TextStyle(fontFamily: 'CenturyGothic')),
                              ) ),
                          Container(
                              color:color6.withOpacity(0.8),
                              height: 40,
                              width: size.width*0.3,
                              child:Center(
                                child: Text(("XP").toString(),style: TextStyle(fontFamily: 'CenturyGothic')) ,
                              ))
                  ],
                ),
                    ),
                    Container(
                      height: heigthpage*0.65-40,
                      color: color3,
                      child: datos(size.width, color3),
                    )
                  ],
                )
            )
          ],
        )
    );
  }
  //Widget de datos qeu devuelve la lista ya construida
  Widget datos(width,color){
    return ListView(
      padding: EdgeInsets.all(0),
      children: resultados.asMap().entries.map((entries){
        return Material(
          elevation: 0,
          color: entries.value[2]==user.uid?color3:Colors.transparent,
          child:  Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color:entries.value[2]==user.uid?color6.withOpacity(0.3):color,border:  entries.key==resultados.length-1?Border(right: BorderSide(color: color6),bottom: BorderSide(color: color6)):Border(right: BorderSide(color: color6))),
                  height: 40,
                  width: width*0.1,
                  child:Center(
                      child:Text((entries.key+1).toString(),style: TextStyle(color: color6,fontFamily: 'CenturyGothic'),)
                  )
              ),
              Container(
                  decoration: BoxDecoration(
                      color:entries.value[2]==user.uid?color6.withOpacity(0.3):color,border: entries.key==resultados.length-1?Border(right: BorderSide(color: color6),bottom: BorderSide(color: color6)):Border(right: BorderSide(color: color6))),
                  height: 40,
                  width: width*0.6-1,
                  child:Center(
                    child: Text((entries.value[0]).toString(),style: TextStyle(color: color6,fontFamily: 'CenturyGothic')),
                  ) ),
              Container(
                  height: 40,
                  width: width*0.3-1,
                  decoration: BoxDecoration(
                      color:entries.value[2]==user.uid?color6.withOpacity(0.3):color,
                    border:  entries.key==resultados.length-1?Border(right: BorderSide(color: color6),bottom: BorderSide(color: color6)):Border(right: BorderSide(color: color6))
                  ),
                  child:Center(
                    child: Text((entries.value[1]).toString(),style: TextStyle(color: color6,fontFamily: 'CenturyGothic')),
                  ) )
            ],
          ),
        );
      }).toList(),
    );
  }

  //FUncion para poder recibir los datos asyncronamente de la base de datos
  recibirDatos()async{
    user=await FirebaseAuth.instance.currentUser();
    var a=await Firestore.instance.collection("Usuarios").orderBy("xp",descending: true).getDocuments();
    int c=1;
    for(var docu in a.documents){
      setState(() {resultados.add([docu.data["Nombre"],docu.data["xp"].toString(),docu.documentID.toString()]);
      if(docu.documentID==user.uid){
        exp=docu.data["xp"];
        puesto=c;
      }
      c++;
      });
    }
  }
}
