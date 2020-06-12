import 'dart:async';

import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int xp=1200;
  int monedas=400;
  int diamantes=400;
  int gemas=200;
  List<String> tipo=["Principiante","Intermedio","Pro","Épico","Leyenda"];
  List<String> imgCoronas=["assets/iconos_rank/corona_1.png","assets/iconos_rank/corona_2.png","assets/iconos_rank/corona_3.png",
    "assets/iconos_rank/corona_4.png","assets/iconos_rank/corona_5.png"];
  int dirmovi=1;
  double posiCorona=-0.1;
  Future reloj(pos)async {
    Completer c=Completer();
    Timer(Duration(milliseconds: dirmovi==1?40:40),(){
      c.complete(mover(pos+dirmovi*0.01));
    });
  }
  mover(pos){
    setState(() {
      posiCorona=pos;
    });
    if(pos<=-0.1){
      setState(() {

        dirmovi=1;
      });
    }else{
      if(pos>=0.1){
        setState(() {

          dirmovi=-1;
        });
      }
    }
    reloj(pos);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mover(-0.5);
  }
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
            height: heigthpage*0.5,
            child:Column(
              children: <Widget>[
                Container(
                  height: heigthpage*0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[Text(xp.toString()+" XP",style: TextStyle(fontSize: size.height*0.05,color: color6),),]
                  )
                ),
                Container(
                  height: heigthpage*0.28,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment(0, posiCorona*0.5),
                        child: Image(image: AssetImage(imgCoronas[xp/1000<5?(xp/1000).truncate():5]),height: heigthpage*0.2-posiCorona*heigthpage*0.05,width: heigthpage*0.2-posiCorona*heigthpage*0.05,)
                        ,
                      )
                    ],
                  )
                ),
                Container(
                  width: size.width,
                  color: color3,
                  height: heigthpage*0.07,
                  child: Center(
                    child: Text(tipo[xp/1000<5?(xp/1000).truncate():5],style: TextStyle(fontSize: size.height*0.03,color: color6,fontFamily: 'CenturyGothic',),),
                  )
                )
              ],
            )
          ),
          Container(
            height: heigthpage*0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width:size.width*0.8,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        recurso(heigthpage*0.25,size.width*0.8, "assets/recursos/monedas.png", monedas.toString()),
                      recurso(heigthpage*0.25,size.width*0.8, "assets/recursos/diamante.png", diamantes.toString())
                    ],
                  )
                ),
                Container(
                  width:size.width*0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        botonCon(Icons.store, color5,color7,size.width*0.12),
                        Divider(height:size.width*0.15,color: Colors.transparent,),
                        botonCon(Icons.settings, color2,color6, size.width*0.12),
                      ],
                    ),]
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
  Widget recurso(heigth,width,image,text){
    return Container(
      height: heigth,
      width: width*0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width:heigth*0.7+posiCorona*heigth*0.08,
            height: image=="assets/recursos/diamante.png"?heigth*0.4+posiCorona*heigth*0.08:heigth*0.7+posiCorona*heigth*0.08,
            child: Center(
              child: Image(image: AssetImage(image),
                width: heigth*0.7+posiCorona*heigth*0.08,
                height: heigth*0.7+posiCorona*heigth*0.08,),
            ),
          ),
          Container(
            width: width,
            height: heigth*0.1,
            child: Center(
              child: image=="assets/recursos/diamante.png"? Text(text,style:TextStyle(fontSize: heigth*0.1)):Text(text+" \u0024",style:TextStyle(fontSize: heigth*0.1)),
            )
          )
        ],
      ),
    );
  }
  Widget botonCon(icon,color,colorico,tam){
    return Container(
      decoration: BoxDecoration(
          color: color,borderRadius: BorderRadius.all(Radius.circular(tam))),
      width: tam,
      height: tam,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Icon(icon,color: colorico,size: tam*0.6,),
        ),
      ),
    );
  }
}
