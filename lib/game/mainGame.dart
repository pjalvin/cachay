
import 'dart:async';
import 'dart:math';

import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/main.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/widgets/animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as animation;
class MainGame extends StatefulWidget {
  @override
  _MainGameState createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  animation.Animation _animation;
  bool apretarCacho=false;




  //bloqueos de objetos
  bool bloqLanzador=false;





  //////////////////////////////
  List<Widget> dadosAnotados=List();
  List<Widget> dadosLanz1=List();
  List<Widget> dadosLanz2=List();
  List dados=[[0,false],[0,false],[0,false],[0,false],[0,false]];

  List dadosRetenidos=[];
  List<int> lanzamiDados=[0,0,0,0,0];
  List<bool> dadosGirando=[false,false,false,false,false];
  List<String> dadosImg=["assets/images/dado1/cara_n.png","assets/images/dado1/cara_1.png","assets/images/dado1/cara_2.png","assets/images/dado1/cara_3.png","assets/images/dado1/cara_4.png"
      ,"assets/images/dado1/cara_5.png","assets/images/dado1/cara_6.png"];




  List<List<int>> puntRivales=[[0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0]];
  List<String> nombRiva=["Juan","Pedro","Luis"];
  var colorRiva=[Colors.teal,Colors.redAccent,Colors.lightBlueAccent];


  cargarRecursos() async {

    WidgetsFlutterBinding.ensureInitialized();

    await Flame.images.load('sprites/dado_sprite.png');
    final _animationSpriteSheet = SpriteSheet(
      imageName: 'sprites/dado_sprite.png',
      columns: 17,
      rows: 1,
      textureWidth: 96,
      textureHeight: 86,
    );
    setState(() {
      _animation = _animationSpriteSheet.createAnimation(
        0,
        stepTime: 0.007,
        to: 17,
      );
    });
    setState(() {
      cargando=false;
    });

  }
  bool cargando=true;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    cargarRecursos();
  }
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage("assets/images/tablero_1.jpg"), context);
    precacheImage(AssetImage("assets/images/dado1/cara_1.png"), context);
    precacheImage(AssetImage("assets/images/dado1/cara_2.png"), context);
    precacheImage(AssetImage("assets/images/dado1/cara_3.png"), context);
    precacheImage(AssetImage("assets/images/dado1/cara_4.png"), context);
    precacheImage(AssetImage("assets/images/dado1/cara_5.png"), context);
    precacheImage(AssetImage("assets/images/dado1/cara_6.png"), context);
    precacheImage(AssetImage("assets/images/cacho.png"), context);
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return cargando==false?
   GestureDetector(
     child:  Scaffold(
       body: Column(
         children: <Widget>[
           Container(
             height: size.height*0.65,
             child: Column(
               children: <Widget>[
                 Container(
                   height: size.height*0.08,
                   width: size.width,
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                         colors: [Colors.green.withOpacity(0.8),color6],
                         stops: [0.01,0.5],
                         begin: FractionalOffset.topCenter,
                         end: FractionalOffset.bottomCenter
                     )
                   ),

                 ),
                 Container(
                   height: size.height*0.57,
                   color: color6,
                   width: size.width,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Container(
                             width: size.width*0.65,
                             height: size.height*0.57,
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children:[
                                 Container(
                                     height: (size.height*0.57)*0.15,
                                     child:Center(
                                       child:Text('Alvin',style: TextStyle(fontSize: (size.height*0.57)*0.1 ,fontFamily: 'CenturyGothic'),),)
                                 ),
                                 panel(size.width*0.65*0.8, (size.height*0.57)*0.8, [0,0,0,0,0,0,0,0,0,0,0],color3,color2,color6,color5,color7)],
                             )

                         ),
                         Container(
                           width: size.width*0.35,
                           child: Column(
                             children:puntRivales.asMap().entries.map((puntr){
                               return Container(
                                   width: size.width*0.35,
                                   height: size.height*0.57/3,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children:[
                                       Container(
                                           height: (size.height*0.57/3)*0.15,
                                           child:Center(
                                             child:Text(nombRiva[puntr.key],style: TextStyle(fontSize: (size.height*0.57/3)*0.1 ,fontFamily: 'CenturyGothic')),)
                                       ),
                                       panel(size.width*0.35*0.8, (size.height*0.53/3)*0.8, puntr.value,color3,color2,color6,colorRiva[puntr.key],color7)],
                                   )

                               );
                             }).toList()
                           ),
                         )
                       ],
                     ),],
                   )

                 )
               ],
             ),
           ),
           Container(
               width: size.width,
               height: size.height*0.35,
               decoration: BoxDecoration(
                   border: Border.all(color: color2,width: 3),
                   color: color7.withOpacity(0.5),
                   image: DecorationImage(
                       colorFilter: ColorFilter.mode(Color(0xff108BF1),BlendMode.colorBurn),
                       image:AssetImage( "assets/images/tablero_1.jpg"),
                       fit:BoxFit.cover
                   )),
               child: Column(
                 children: <Widget>[
                   Container(
                       height: size.height*0.29-6,
                       child: Row(
                         children: <Widget>[
                           Container(
                             width: size.width*0.7-6,
                             child:
                             Center(
                               child: tableLanza(size.width*0.6,(size.height*0.29-6)*0.7),
                             ),
                           ),
                           Container(
                               width: size.width*0.3,
                               child:Center(
                                 child: lanzador(size.width*0.3, (size.height*0.29-6)*0.5),
                               )
                           )
                         ],
                       )
                   ),
                   Container(
                     padding: EdgeInsets.all(size.height*0.01),
                     height: size.height*0.06,
                     decoration: BoxDecoration(
                       border: Border.all(color: color7),
                       borderRadius: BorderRadius.circular(size.height*0.06*0.2)
                       ,
                       image: DecorationImage(
                           colorFilter: ColorFilter.mode(color3,BlendMode.color),
                           image:AssetImage( "assets/images/tablero_1.jpg"),
                           fit:BoxFit.cover
                       ),
                     ),
                     child: anotado(size.height*0.04*5+size.height*0.01*4, size.height*0.04),
                   )
                 ],
               )
           )
         ],
       ),
     ),
   )
    :Container(child: Center(child: Text('Cargando'),),);
  }
  Widget panel(width,height,List list,color3,color2,color6,color5,color7){
    return Container(
          width: width>height?height:width,
      height: width>height?height:width,
      decoration: BoxDecoration(
          color: color3,
        borderRadius: BorderRadius.circular(width>height?height*0.04:width*0.04)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width>height?height:width,
            height: width>height?(height)/4:(width)/4,
            child: filapanel(width>height?height:width, list[0], list[1], list[2], 1,color2,color6,color5,color7),
          ),
          Container(
            width: width>height?height:width,
            height: width>height?(height)/4:(width)/4,
            child: filapanel(width>height?height:width, list[3], list[4], list[5], 1,color2,color6,color5,color7),
          ),
          Container(
            width: width>height?height:width,
            height: width>height?(height)/4:(width)/4,
            child: filapanel(width>height?height:width, list[6], list[7], list[8], 3,color2,color6,color5,color7),
          ),
          Container(
            width: width>height?height:width,
            height: width>height?(height)/4:(width)/4,
            child: filapanel2(width>height?height:width, list[9], list[10],color2,color6,color5,color7),
          ),
        ],
      ),
    );
  }
  Widget filapanel2(width,a,b,color2,color6,color5,color7){
    width=width;
    return Row(
      children: <Widget>[
        Container(
          width: width/2,
          height: width/3,
          decoration: BoxDecoration(
            color: color6,
              border: Border.all(color: color2,width: 3)
          ),
          child: a!=0?Text(a):Text(""),
        ),
        Container(
          width: width/2,
          height: width/3,
          decoration: BoxDecoration(
              color: color6,

              border: Border(bottom:BorderSide(color: color2,width: 3),top:BorderSide(color: color2,width: 3),right:BorderSide(color: color2,width: 3))
          ),
          child: b!=0?Text(b):Text(""),),
      ],
    );
  }
  Widget filapanel(width,a,b,c,d,color2,color6,color5,color7){
    width=width;
    return Row(
      children: <Widget>[
        Container(
          width: width/3,
          height: width/3,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: color6,width: 3),bottom: BorderSide(color:color6,width: d==3?0:3))
          ),
          child: a!=0?Text(a):Text(""),
        ),
        Container(
          width: width/3,
          height: width/3,
          decoration: BoxDecoration(
            color: color5.withOpacity(0.7),
              border: Border(right: BorderSide(color: color6,width: 3),bottom: BorderSide(color:color6,width: d==3?0:3))
          ),
          child: b!=0?Text(b):Text(""),),
        Container(
          width: width/3,
          height: width/3,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color:color6,width: d==3?0:3))
          ),
          child: c!=0?Text(c):Text(""),),
      ],
    );
  }
  Widget lanzador(width,height){
    return  Container(
          width:apretarCacho?width: width*0.9,
          height: apretarCacho?height:height*0.9,
          child:GestureDetector(

            child: apretarCacho?Image.asset("assets/images/cacho2.png",width: width,height: height,):Image.asset("assets/images/cacho.png",width: width*0.9,height: height*0.9,),
            onTapDown: (pres){
              if(!bloqLanzador&&dados.length>0){
                setState(() {
                  apretarCacho=!apretarCacho;
                  dados.forEach((val){
                      val[1]=!val[1];
                  });
                  bloqLanzador=!bloqLanzador;
                  esperarlanzamiento();
                  Future.delayed(Duration(milliseconds: 100)).then((val){
                    setState(() {
                      apretarCacho=!apretarCacho;
                    });
                  });

                });
              }

            },

          )
      );
  }
  Widget tableLanza(width,height){
    print(width);
    print(((width-6-height*0.2)-height*0.9)/3,);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(width*0.05),
      child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(height*0.05),
          decoration: BoxDecoration(
              border:Border.all(color:color2,width: 3),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(Color(0xff8F0A0F),BlendMode.color),
                  image:AssetImage( "assets/images/tablero_1.jpg"),
                  fit:BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(width*0.05)
          ),
          child:/*Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  dadosGirando[0]?dadoGira(height*0.4,height*0.4):dado(lanzamiDados[0], "lanza", height*0.4),
                  dadosGirando[1]?dadoGira(height*0.4,height*0.4):dado(lanzamiDados[1], "lanza", height*0.4),
                  dadosGirando[2]?dadoGira(height*0.4,height*0.4):dado(lanzamiDados[2], "lanza", height*0.4)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  dadosGirando[3]?dadoGira(height*0.4,height*0.4):dado(lanzamiDados[3], "lanza", height*0.4),
                  dadosGirando[4]?dadoGira(height*0.4,height*0.4):dado(lanzamiDados[4], "lanza", height*0.4)
                ],


              )
            ],
          )*/
        Center(
          child: GridView.count(
            padding: EdgeInsets.all(0),

            crossAxisCount: 3,
            crossAxisSpacing: ((width-6-height*0.1)-3*height*0.4)/2,
            children: dados.asMap().entries.map((data){
                return data.value[1]?dadoGira(height*0.4,height*0.4):dado(data.value[0], "lanza", height*0.4,data.key);
            }).toList(),
          ),
        )
      ),
    );
  }
  Widget dadoGira(width,height){
    return Center(
      child: Container(
        width: width,
        height: height,
        child: AnimationWidget(animation: _animation,),
      ),
    );
  }

  Future esperarlanzamiento()async {
    var data=await FuncionesJuegos().randNum(dados.length);
    Timer(Duration(milliseconds:100),(){
        setState(() {
          int c=0;
          dados.forEach((val){
            val[1]=!val[1];
            setState(() {
              val[0]=data[c];
              print(val[0]);
              bloqLanzador=false;
            });
            c++;
          });
        });
    });
  }
  Widget anotado(width,height){
    return Container(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: dadosRetenidos.asMap().entries.map((val){
          return dado(val.value[0], "anotar", width/5,val.key);
        }).toList(),
      )
    );
  }
  Widget dado(numero,tipo,width,i){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width*0.05),),
          padding: tipo=="anotar"?EdgeInsets.all(0):EdgeInsets.all(width*0.25),
      child: Container(
        width: width*0.75,
        height:width*0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width*0.05),
            color: color7.withOpacity(0.5),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Color(0xff108BF1),BlendMode.colorBurn),
                image:AssetImage( dadosImg[numero]),
                fit:BoxFit.cover
            )),
        child: MaterialButton(
            onPressed: (){
              print("fasdf");
              switch (tipo){
                case "lanza":
                  if(dados[i][0]!=0){
                    setState(() {
                    dadosRetenidos.add(dados[i]);
                    dados.removeAt(i);
                    });
                  }
                  break;
                case "anotar":
                  setState(() {
                    dados.add(dadosRetenidos[i]);
                    dadosRetenidos.removeAt(i);
                  });
                  break;
              }
            }
        ),

      ),
    );
  }
}
