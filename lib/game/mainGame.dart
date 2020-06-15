
import 'dart:async';
import 'dart:math';

import 'package:cachay/game/ayuda_juego/Ayuda.dart';
import 'package:cachay/game/componentes/Dados.dart';
import 'package:cachay/game/componentes/Panel.dart';
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
  _MainGameState createState() => _MainGameState(size);
  Size size;
  MainGame(this.size);
}

class _MainGameState extends State<MainGame> {
  _MainGameState(this.size);
  //recursos
  Size size;
  animation.Animation _animation;
  animation.Animation _animationVolteo;
  var colorRiva = [color5,Colors.teal, Colors.redAccent, Colors.lightBlueAccent];
  int paso = 1;
  List<List<double>> PosTableros;
  List<List<double>> TamTableros;
  Offset pos1,pos2,pos3,pos4;
  Offset tam1,tam2;
  ///////////////////////////


  //bloqueos de objetos
  bool bloqLanzador = false;
  bool apretarCacho = false;
  bool cargando = true;
  int bloqueoVolteos=0;
  int contadorTiros=0;
  int contadorVolteos=0;

  //////////////////////////////



  //Jugadas
  List<String> jugadas=["Balas","Tontos","Trenes",
                        "Cuadras","Quinas","Senas",
                        "Escalera","Full","Poker","Grande"];
  int cantDado=0;
  List grupos=[];
  String ValorDrop;
  List<int>valor=[25,35,45,50];
  /////////////////////



  //dados

  List dados = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0]];
  List dadosRetenidos = [];
  List dadosAnotar=[];
  List<String> dadosImg = [
    "assets/images/dado1/cara_n.png",
    "assets/images/dado1/cara_1.png",
    "assets/images/dado1/cara_2.png",
    "assets/images/dado1/cara_3.png",
    "assets/images/dado1/cara_4.png"
    ,
    "assets/images/dado1/cara_5.png",
    "assets/images/dado1/cara_6.png"
  ];

  /////////////////////////


  //informacion de la partida

  List<List<int>> puntuaciones = [
    [0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];
  List<String> nombRiva = ["Alvin", "Juan", "Pedro", "Luis"];
  List<Widget> ayudas = [
    Ayudas().Ayuda1(),
    Ayudas().Ayuda2(),
    Ayudas().Ayuda3(),
    Ayudas().Ayuda4()
  ];

  /////////////////////////////////////////


  ////funciones del juego
  iniciarJugada() {

  }


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
      _animationVolteo = _animationSpriteSheet.createAnimation(
        0,
        stepTime: 0.001,
        to: 17,
      );
    });
    setState(() {
      cargando = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarRecursos();
    tam2=Offset(size.width/3, size.height * 0.57 / 3);
    tam1=Offset(size.width * 0.61,size.height * 0.57);
    pos1=Offset(size.width/2-tam1.dx/2,size.height * 0.57*0.2);
    pos2=Offset(0, size.height * 0.57*0.4 / 3);
    pos3=Offset(size.width/3,0);
    pos4=Offset(size.width/3*2,size.height * 0.57*0.4 / 3);
    TamTableros=[[tam1.dx,tam1.dy],[tam2.dx,tam2.dy],[tam2.dx,tam2.dy],[tam2.dx,tam2.dy]];
    PosTableros=[[pos1.dx,pos1.dy],[pos2.dx,pos2.dy],[pos3.dx,pos3.dy],[pos4.dx,pos4.dy]];
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
  Panel2(size,i,width,height){
    return Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center,
          children: [
            Container(
                height: (height) * 0.15,
                child: Center(
                  child: Text(
                      nombRiva[i],
                      style: TextStyle(
                          fontSize: (height) *
                              0.1,
                          fontFamily: 'CenturyGothic')),)
            ),
            Panel().panel(
                width * 0.8,
                (height) *
                    0.8,
                puntuaciones[i],
                color3,
                color2,
                color6,
                colorRiva[i],
                color7)
          ],
        )

    );
  }
  Panel1(size,i){

    return Container(
        width: size.width * 0.65,
        height: size.height * 0.57,
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center,
          children: [
            Container(
                height: (size.height * 0.57) * 0.15,
                child: Center(
                  child: Text(nombRiva[i],
                    style: TextStyle(
                        fontSize: (size.height *
                            0.57) * 0.1,
                        fontFamily: 'CenturyGothic'),),)
            ),
            Panel().panel(
                size.width * 0.65 * 0.8,
                (size.height * 0.57) * 0.8,
                puntuaciones[i],
                color3,
                color2,
                color6,
                color5,
                color7)
          ],
        )

    );
  }
  Future moverTablas(duracion)async{
    setState(() {
      paso=0;
    });
    List<List<double>> tamMov=List();
    tamMov.add([(PosTableros[PosTableros.length-1][0]-PosTableros[0][0])/duracion,(PosTableros[PosTableros.length-1][1]-PosTableros[0][1])/duracion]);
    int min=1;
    int max=0;
    double tamdesp1=(tam1.dx-tam2.dx)/duracion;
    double tamdesp2=(tam1.dy-tam2.dy)/duracion;
    for(int i=1;i<PosTableros.length;i++){

      if(TamTableros[i][0].round()==tam1.dx.round()&&TamTableros[i][1].round()==tam1.dy.round()){
            max=i;
      }
      tamMov.add([(PosTableros[i-1][0]-PosTableros[i][0])/duracion,(PosTableros[i-1][1]-PosTableros[i][1])/duracion]);
    }
    if(max==TamTableros.length-1){
      min=0;
    }
    else{
      min=max+1;
    }

    for(int i=0;i<duracion;i++){
        TamTableros[min][0]+=tamdesp1;
        TamTableros[min][1]+=tamdesp2;
        TamTableros[max][0]-=tamdesp1;
        TamTableros[max][1]-=tamdesp2;
        for(int i=0;i<PosTableros.length;i++){
          setState(() {
            PosTableros[i][0]+=tamMov[i][0];
            PosTableros[i][1]+=tamMov[i][1];
          });
        }

    await Future.delayed(Duration(microseconds:2));
    }
    setState(() {
      paso=1;
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      size= MediaQuery
          .of(context)
          .size;
    });

    return cargando == false ?
    GestureDetector(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
                height: size.height * 0.65,
                child: Stack(
                  children: <Widget>[Column(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.04,
                        width: size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.green.withOpacity(0.8), color6],
                                stops: [0.01, 0.5],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter
                            )
                        ),

                      ),
                      Container(
                          height: size.height * 0.61,
                          color: color6,
                          width: size.width,
                          child: Stack(
                            children:PosTableros.asMap().entries.map((entrie){
                              return Positioned(
                                top: entrie.value[1],
                                left: entrie.value[0],
                                child: Panel2(size,entrie.key,TamTableros[entrie.key][0],TamTableros[entrie.key][1])
                              );
                            }).toList()
                          )

                      )
                    ],
                  ),

                  ],
                )
            ),
            Container(
                width: size.width,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                    border: Border.all(color: color2, width: 3),
                    color: color7.withOpacity(0.5),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color(0xff108BF1), BlendMode.colorBurn),
                        image: AssetImage("assets/images/tablero_1.jpg"),
                        fit: BoxFit.cover
                    )),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: size.height * 0.29 - 6,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: size.width * 0.7 - 6,
                              child:
                              Center(
                                child: tableLanza(size.width * 0.6,
                                    (size.height * 0.29 - 6) * 0.7),
                              ),
                            ),
                            Container(
                                width: size.width * 0.3,
                                child: Center(
                                  child: lanzador(size.width * 0.3,
                                      (size.height * 0.29 - 6) * 0.5),
                                )
                            )
                          ],
                        )
                    ),
                    paso==1||paso==2||paso==0
                    ?Container(
                      padding: EdgeInsets.all(size.height * 0.01),
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: color7),
                        borderRadius: BorderRadius.circular(
                            size.height * 0.06 * 0.2)
                        ,
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                color3, BlendMode.color),
                            image: AssetImage("assets/images/tablero_1.jpg"),
                            fit: BoxFit.cover
                        ),
                      ),
                      child: anotado(
                          size.height * 0.04 * 5 + size.height * 0.01 * 4,
                          size.height * 0.04),
                    )
                    :paso==3||paso==5
                    ?botonAbajo(size.height * 0.04 * 5 + size.height * 0.01 * 4, size.height * 0.06, "Siguiente", color5)
                        :abajopaso4(size.width*0.8, size.height * 0.06, Colors.blueGrey)
                  ],
                )
            )
          ],
        ),
      ),
    )
        : Container(child: Center(child: Text('Cargando'),),);
  }




  Widget lanzador(width, height) {
    return Container(
        width: apretarCacho ? width : width * 0.9,
        height: apretarCacho ? height : height * 0.9,
        child: GestureDetector(

          child: apretarCacho ? Image.asset(
            "assets/images/cacho2.png", width: width, height: height,) : Image
              .asset("assets/images/cacho.png", width: width * 0.9,
            height: height * 0.9,),
          onTapDown: (pres) async {
            if (!bloqLanzador ) {
              if(dados.length ==0){
                await moverDadospaso3();
                setState(() {
                  paso++;
                });
              }
              else{
                switch (paso) {
                  case 1:
                    await lanzarDados1();
                    setState(() {
                      paso++;
                      contadorTiros++;
                    });
                    break;
                  case 2:
                    await lanzarDados2();
                    await moverDadospaso3();
                    setState(() {
                      paso++;
                      contadorTiros++;
                    });
                    break;
                  case 3:
                    break;
                  case 4:
                    break;
                }
              }


            }
          },

        )
    );
  }

  Widget tableLanza(width, height) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(width * 0.05),
      child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(height * 0.05),
          decoration: BoxDecoration(
              border: Border.all(color: color2, width: 3),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color(0xff8F0A0F), BlendMode.color),
                  image: AssetImage("assets/images/tablero_1.jpg"),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(width * 0.05)
          ),
          child:
          Center(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),

              crossAxisCount: 3,
              crossAxisSpacing: ((width - 6 - height * 0.1) -
                  3 * height * 0.4) / 2,
              children: dados
                  .asMap()
                  .entries
                  .map((data) {
                return data.value[1]==1
                    ? Dados().dadoGira(height * 0.4, height * 0.4,1,_animation,_animationVolteo)
                    : data.value[1]==2
                    ? Dados().dadoGira(height * 0.4, height * 0.4,2,_animation,_animationVolteo)
                    : data.value[1]==3
                    ?dado(data.value[0], "lanza", height * 0.4, data.key,1)
                    :data.value[1]==0&&paso==4
                    ?dado(data.value[0], "lanza", height * 0.4, data.key,2)
                    :dado(data.value[0], "lanza", height * 0.4, data.key,1);
              }).toList(),
            ),
          )
      ),
    );
  }

  Widget anotado(width, height) {
    return Container(
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dadosRetenidos
              .asMap()
              .entries
              .map((val) {
            return dado(val.value[0], "bloqueo", width / 5, val.key,1);
          }).toList(),
        )
    );
  }

  Widget dado(numero, tipo, width, i,tipocolor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.05),),
      padding: tipo == "bloqueo" ? EdgeInsets.all(0) : EdgeInsets.all(
          width * 0.25),
      child: Container(
        width: width * 0.75,
        height: width * 0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.05),
            image: DecorationImage(
                image: AssetImage(dadosImg[numero]),
                fit: BoxFit.cover
            )),
        child: MaterialButton(
            elevation: 20,
            color:tipocolor==2?color7.withOpacity(0.5):Colors.transparent,
            onPressed: () async{
              switch (tipo) {
                case "lanza":
                  switch (paso) {
                    case 1:
                      break;
                    case 2:
                      await intercambiarDados1(i);
                      break;
                    case 3:
                      volteoDados(i);
                      bloqueoVolteos++;
                      break;
                    case 4:
                      AgruparDadosAnotar(i);
                      break;
                  }
                  break;
                case "bloqueo":
                  switch (paso) {
                    case 1:
                      break;
                    case 2:
                      await intercambiarDados2(i);
                      break;
                    case 3:
                      break;
                    case 4:
                      break;
                  }
                  break;
              }
            }
        ),

      ),
    );
  }
  Widget abajopaso4(width,height,color){
    return Container(
      width: width,
      height: height,
      child: Row(
        children: <Widget>[
         Container(
           width: width*0.5,decoration: BoxDecoration(
           image: DecorationImage(
               colorFilter: ColorFilter.mode(
                   color.withOpacity(0.8), BlendMode.color),
               image: AssetImage("assets/images/tablero_1.jpg"),
               fit: BoxFit.cover
           ),
           border: Border.all(color: color6),
           borderRadius: BorderRadius.circular(
               height * 0.2)
           ,
         ),
           child:  Center(
             child: Theme(
                 data: Theme.of(context).copyWith(
                   canvasColor: Color(0xffCA595D).withOpacity(0.9),),
               child: DropdownButton<String>(
                   radius: height*0.2,
                   onChanged: (String changedValue) {
                     ValorDrop=changedValue;
                     setState(() {
                       ValorDrop;
                       print(ValorDrop);
                     });
                   },
                   value: ValorDrop,
                   items:
                   grupos.map((value) {
                     return DropdownMenuItem<String>(
                       value: value[0]!=0?value[0].toString()+" "+
                           jugadas[value[1]]:jugadas[value[1]],
                       child: Text(value[0]!=0?value[0].toString()+" "+
                           jugadas[value[1]]:jugadas[value[1]],style:TextStyle(fontFamily: 'CenturyGothic',fontSize: height*0.35,color: color6)),
                     );
                   }).toList()),
             )
           )
         ),
    VerticalDivider(width: width*0.1-2,),
          botonFinalizar(width, height, color, "Anotar")

        ],
      )
    );
  }
  Widget botonFinalizar(width,height,color,texto){
    return Container(
      width: width*0.4,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                color, BlendMode.color),
            image: AssetImage("assets/images/tablero_1.jpg"),
            fit: BoxFit.cover
        ),
        border: Border.all(color: color6),
        borderRadius: BorderRadius.circular(
            height * 0.2)
        ,
      ),
      child: MaterialButton(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(
            height * 0.2)),
        child: Text(texto,style: TextStyle(color: color6,fontSize: height*0.5,fontFamily: 'CenturyGothic'),),
        onPressed: (){
          switch(paso){
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              setState(() {
                paso++;
              });
              break;
          }
        },
      ),
    );
  }
  Widget botonAbajo(width,height,texto,color){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                color.withOpacity(0.8), BlendMode.color),
            image: AssetImage("assets/images/tablero_1.jpg"),
            fit: BoxFit.cover
        ),
        border: Border.all(color: color6),
        borderRadius: BorderRadius.circular(
            height * 0.2)
        ,
      ),
      child: MaterialButton(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(
            height * 0.2)),
        child: Text(texto,style: TextStyle(color: color6,fontSize: height*0.5),),
        onPressed: (){
            switch(paso){
              case 1:
                break;
              case 2:
                break;
              case 3:
                setState(() {
                  paso++;
                });
                break;
              case 4:
                break;
            }
        },
      ),
    );
  }
  sacarTipo(String tipo){
    var dev=[0,0];
    String busq=tipo;
    var div=tipo.split(" ");
    if(div.length==2){
      busq=div[1];
      dev[0]=int.parse(div[0]);
    }
    for(int i=0;i<jugadas.length;i++){
      if(jugadas[i]==tipo){
        dev[1]=i;
        break;
      }
    }
    return dev;
  }
  anotarLanzado(lanz){
    var verlan=sacarTipo(lanz);
  }
  //funciones del juego
  lanzarDados2() async {
    setState(() {
      apretarCacho = !apretarCacho;
      dados.forEach((val) {
        val[1] = 1;
      });
      bloqLanzador = !bloqLanzador;
    });
      await esperarlanzamiento();
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        apretarCacho = !apretarCacho;
      });
  }

  verificarDispo(i){
    if(puntuaciones[0][i]>0){
      return false;
    }
    else{
      return true;
    }
  }
  verificarEscalera(){
    List<int> numeroDados=List();
    for(int i=0;i<dadosAnotar.length;i++){
      numeroDados.add(dados[dadosAnotar[i]][0]);
    }
    numeroDados.sort();
    bool bien=true;
    if(numeroDados[0]==2){
      int c=0;
      for(int i=2;i<=6;i++){
        if(numeroDados[c]!=i){
          bien=false;
        }
        c++;
      }
    }
    else{
      if(numeroDados[0]==1){
        int c=0;
        for(int i=1;i<=5;i++){
          if(numeroDados[c]!=i){
            bien=false;
          }
          c++;
        }
      }
      else{
        if(numeroDados[0]==3&&numeroDados[4]==1){
          int c=0;
          for(int i=3;i<=6;i++){
            if(numeroDados[c]!=i){
              bien=false;
            }
            c++;
          }
        }
        else{
          bien=false;
        }
      }
    }
    return bien;
  }
  List<List<int>>detGrupo(){
    List<List<int>> retornoTipos=List();
    if(dadosAnotar.length==0){
      return retornoTipos;
    }
    else{
      int vernumEsp=0;
      int vernumEsp2=0;
      bool verinumnorm=true;

      for(int i=0;i<dadosAnotar.length;i++){
          if(dados[dadosAnotar[i]][0]==dados[dadosAnotar[0]][0]){
            vernumEsp++;
          }
          else{
            vernumEsp2++;
            verinumnorm=false;
          }
      }
      if(vernumEsp==5){
        if(verificarDispo(9)){
            retornoTipos.add([0,9]);
        }
        else{
          if(verificarDispo(10)){
            retornoTipos.add([0,9]);
          }
        }
      }
      if(verinumnorm){
        retornoTipos.add([vernumEsp,dados[dadosAnotar[0]][0]-1]);
      }
      if((vernumEsp==3&&vernumEsp2==2)||(vernumEsp==2&&vernumEsp2==3)){
        retornoTipos.add([0,7]);
      }
      if((vernumEsp==4||vernumEsp2==4)&&(vernumEsp+vernumEsp2!=5)){
        retornoTipos.add([0,8]);
      }
      if(dadosAnotar.length==5){
        if(verificarEscalera()){
          retornoTipos.add([0,6]);
        }
      }

      return retornoTipos;
      }

  }
  AgruparDadosAnotar(i){
      if(paso==4){
        if(!dadosAnotar.asMap().containsValue(i)){
        setState(() {
          dadosAnotar.add(i);
          dados[i][1]=3;
          grupos=detGrupo();
          if(grupos.length>0){
            ValorDrop=grupos[0][0]!=0?grupos[0][0].toString()+" "+jugadas[grupos[0][1]]:jugadas[grupos[0][1]];
          }
        });
        print("grupo"+detGrupo().toString());
        }
        else{
          setState(() {
            dadosAnotar.remove(i);
            dados[i][1]=0;
            grupos=detGrupo();
              if(grupos.length>0){
                  ValorDrop=grupos[0][0]!=0?grupos[0][0].toString()+" "+jugadas[grupos[0][1]]:jugadas[grupos[0][1]];
            }
          });
          print("grupo"+detGrupo().toString());
        }
      }
      print(dadosAnotar);
  }
  random(){
    setState(() {
      int c = 0;
      dados.forEach((val) {
        val[1] = 0;
        setState(() {
          val[0] = 1+Random().nextInt(5);
          print(val[0]);
          bloqLanzador = false;
        });
        c++;
      });
    });
  }
  Future esperarlanzamiento() async {
    Completer c=Completer();
    await Future.delayed(Duration(milliseconds: 1000));
    random();
  }


  lanzarDados1()async{
    setState(() {
      apretarCacho = !apretarCacho;
      dados.forEach((val) {
        val[1] = 1;
      });
      bloqLanzador = !bloqLanzador;
    });
      await esperarlanzamiento();
      await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      apretarCacho = !apretarCacho;
    });
  }
  //intercambio de dados
  intercambiarDados1(i) {
    if (dados[i][0] != 0) {
      setState(() {
        dadosRetenidos.add(dados[i]);
        dados.removeAt(i);
      });
    }
  }
  moverDadospaso3(){
    if(paso==2){
      for(int i=0;i<dadosRetenidos.length;i++){
        setState(() {
          dados.add(dadosRetenidos[i]);
        });
      }
      setState(() {
        dadosRetenidos.clear();
      });
    }
  }
  intercambiarDados2(i) {
    setState(() {
      dados.add(dadosRetenidos[i]);
      dadosRetenidos.removeAt(i);
        });
      }
  Future esperarVolteo(i)async {
    Timer(Duration(milliseconds: 100), () {
      setState(() {
        dados[i][0]=7-dados[i][0];
        dados[i][1]=0;
        paso=3;
      });

    });
  }
  volteoDados(i)async{
    if(paso==3&&bloqueoVolteos<2){
        setState(() {
          paso=5;
          dados[i][1]=2;
        });
        await esperarVolteo(i);
    }
  }


}








