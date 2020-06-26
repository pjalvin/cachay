//Pantalla de inicio de la aplicacion
//Aqui se meustra informacion sobre ut posicion
//y con los recursos que cuentas ahora
import 'dart:async';
import 'package:cachay/User/Profile.dart';
import 'package:cachay/game/componentes/Tablero1/Panel.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
class Inicio extends StatefulWidget {
  //Aqui se obtiene el perfil del usuario desde la pantalla anterior
  final Profile profile;
  @override
  _InicioState createState() => _InicioState();
  Inicio({
    Key key,
    @required this.profile,
  }) : super(key: key);
}

class _InicioState extends State<Inicio> {

  //Recursos de la aplicacion inicial
  List<String> tipo=["Principiante","Intermedio","Pro","Épico","Leyenda"];
  List<String> imgCoronas=["assets/iconos_rank/corona_1.png","assets/iconos_rank/corona_2.png","assets/iconos_rank/corona_3.png",
    "assets/iconos_rank/corona_4.png","assets/iconos_rank/corona_5.png"];
  int dirmovi=1;
  double posiCorona=-0.1;
  bool bloqueo=false;
/////////////////////////////////////////////

  @override
  void dispose() {
    super.dispose();
    bloqueo=true;
  }
  @override
  void initState() {
    //Aqui llama a mi funcion inicial de movimiento
   if(this.mounted){
     super.initState();
     mover(-0.5);
   }
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
                //Aqui se meustran los xp del jugador
                Container(
                  height: heigthpage*0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[Text(widget.profile.xp.toString()+" XP",style: TextStyle(fontSize: size.height*0.05,color: color6),),]
                  )
                ),

                //Aqui le muestra la corona que tiene el jugador dependiendo de su xp
                Container(
                  height: heigthpage*0.28,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment(0, posiCorona*0.5),
                        child: Image(image: AssetImage(imgCoronas[widget.profile.xp/1000<5?(widget.profile.xp/1000).truncate():5]),height: heigthpage*0.2-posiCorona*heigthpage*0.05,width: heigthpage*0.2-posiCorona*heigthpage*0.05,)
                        ,
                      )
                    ],
                  )
                ),
                //Aqui le muestra la leyenda de su estatus dependiendo del xp que tenga
                Container(
                  width: size.width,
                  color: color3,
                  height: heigthpage*0.07,
                  child: Center(
                    child: Text(tipo[widget.profile.xp/1000<5?(widget.profile.xp/1000).truncate():5],style: TextStyle(fontSize: size.height*0.03,color: color6,fontFamily: 'CenturyGothic',),),
                  )
                )
              ],
            )
          ),
          //Aqui estan lso widgets de recursos del jugador de oro y diamantes
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
                        Panel().recurso(heigthpage*0.25,size.width*0.8, "assets/recursos/monedas.png", widget.profile.oro.toString(),posiCorona),
                      Panel().recurso(heigthpage*0.25,size.width*0.8, "assets/recursos/diamante.png", widget.profile.diamantes.toString(),posiCorona)
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
                        Panel().botonCon(Icons.store, color5,color7,size.width*0.12),
                        Divider(height:size.width*0.15,color: Colors.transparent,),
                        Panel().botonCon(Icons.settings, color2,color6, size.width*0.12),
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
  //Hilo de espera para poder mover las coronas y los recursos
  Future reloj(pos)async {
    Completer c=Completer();
    Timer(Duration(milliseconds: dirmovi==1?40:40),(){
      c.complete(mover(pos+dirmovi*0.01));
    });
  }

  //Funcion para mover la posicion de la corona
  mover(pos){
    if(!bloqueo){
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
  }

}
