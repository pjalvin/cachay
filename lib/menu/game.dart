import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
class Game extends StatefulWidget {
  @override
   GameState createState() =>  GameState();
}

class  GameState extends State <Game> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      heightnav=appbar.preferredSize.height;
    });
  }
  double heightnav;
  var appbar=AppBar(
  backgroundColor: color1.withOpacity(0.8),
  title: Center(
  child: Text("Partida",style: TextStyle(color: color6,fontSize: 20),),  ),
  );
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    double heightpage=size.height-50;
    return Scaffold(
      body: Container(

        color: color6,
        height: heightpage,
        child: Column(
          children: <Widget>[
           Container(
             decoration: BoxDecoration(
                 color: color7,
                 image: DecorationImage(
                     image:AssetImage( "assets/recursos/dados2.jpg"),
                     fit:BoxFit.cover
                 )),
             child: Container(
               color: color7.withOpacity(0.5),
               child: Column(
                 children: <Widget>[
                   Container(
                       width: size.width,
                       height: heightpage*0.35,
                       child: Column(
                         mainAxisAlignment:MainAxisAlignment.center,
                         children: <Widget>[

                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: <Widget>[
                               botonJuego(size.width*0.25, "assets/recursos/dados1.jpg", "1v1"),
                               botonJuego(size.width*0.25, "assets/recursos/dados2.jpg", "1v3"),
                             ],
                           ),
                         ],
                       )
                   ),
                   Container(
                     height: heightpage*0.15,
                     child: Center(
                       child: Text("Online",style: TextStyle(fontSize: size.height*0.06,color: color6,letterSpacing: 2.5,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold),),
                     ),
                   ),
                 ],
               ),
             )
           ),
           Container(
             decoration: BoxDecoration(
                 color: color7.withOpacity(0.5),
                 image: DecorationImage(
                     image:AssetImage( "assets/recursos/dados4.jpg"),
                     fit:BoxFit.cover
                 )),
             child: Container(
               color: color7.withOpacity(0.5),
               child: Column(
                 children: <Widget>[
                   Container(
                     width: size.width,
                     height: heightpage*0.35,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: <Widget>[
                         botonJuego(size.width*0.25, "assets/recursos/dados3.jpg", "+"),
                         botonJuego(size.width*0.25, "assets/recursos/dados4.jpg", "a"),],
                     ),
                   ),
                   Container(
                     height: heightpage*0.15,
                     child: Center(
                       child: Text("Sala",style: TextStyle(fontSize: size.height*0.06,color: color6,letterSpacing: 2.5,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold),),
                     ),
                   ),
                 ],
               ),
             )
           )
          ],
        ),
      ),
    );
  }
  Widget botonJuego(width,image,text){
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(width)),color: color6.withOpacity(0.5)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(width))),
        padding: EdgeInsets.all(0),
        child: text=="+"?Icon(Icons.add,color: color7.withOpacity(0.8),size:width*0.5):text=="a"?Icon(Icons.vpn_key,color: color7.withOpacity(0.8),size:width*0.4):Text(text,style: TextStyle(color: color7.withOpacity(0.8),fontSize:width*0.25)),
        onPressed: (){
          switch(text){
            case "1v1":
              break;
            case "1v3":
              break;
            case "+":
              break;
            case "a":
              break;
          }
        },
      ),
    );

  }
}
