//MainGame Principal
//Aqui es donde se genera el juego y se unen todas las funciones y partes de este

import 'dart:async';
import 'dart:math';

import 'package:cachay/User/Profile.dart';
import 'package:cachay/game/bloc/bloc.dart';
import 'package:collection/collection.Dart';
import 'package:cachay/game/componentes/Extras/Ayuda.dart';
import 'package:cachay/game/componentes/Extras/Carga.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/Dados.dart';
import 'package:cachay/game/componentes/Tablero2/DadosBloqueados.dart';
import 'package:cachay/game/componentes/Tablero1/Panel.dart';
import 'package:cachay/game/componentes/Tablero2/Lanzador.dart';
import 'package:cachay/game/componentes/Tablero2/SelecJugada.dart';
import 'package:cachay/game/componentes/Tablero2/TableLanza.dart';
import 'package:cachay/game/componentes/Tablero2/TableLanzaOponente.dart';
import 'package:cachay/game/componentes/Tablero1/TableroAnotacion.dart';
import 'package:cachay/game/componentes/Extras/Terminado.dart';
import 'package:cachay/game/componentes/Tablero2/botonSiguiente.dart';
import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/game/repository/game_repository.dart';
import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/widgets/animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as animation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class MainGame extends StatefulWidget {
  @override
  _MainGameState createState() => _MainGameState(size,idSala,tipo,id);
  Size size;
  String idSala;
  int tipo;
  String id;
  MainGame(this.size,this.idSala,this.tipo,this.id);
}

class _MainGameState extends State<MainGame> {
  _MainGameState(this.size,this.idSala,this.tipo,this.id);

  //Variables info de la partida
  String id;
  String idSala;
  int tipo;
  ////////////////////

  //recursos
  bool mover=false;
  int crono;
  Size size;
  animation.Animation _animation;
  animation.Animation _animationVolteo;
  var colorRiva = [color5,Colors.green, Color(0xffFA7659), Colors.lightBlueAccent];

  List<List<double>> PosTableros;
  List<List<double>> TamTableros;
  Offset pos1,pos2,pos3,pos4;
  Offset tam1,tam2;
  List<String> jugadas=["Balas","Tontos","Trenes",
                        "Cuadras","Quinas","Senas",
                        "Escalera","Full","Poker","Grande"];
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
  List<List<int>> puntuaciones = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];
  int cont=0;
  int cont2=1;
  Game  stateL;
  /////////////////////////////////////////



//Recursos para la animacion del dado
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

    tam2 = Offset(size.width / 3, size.height * 0.57 / 3);
    tam1 = Offset(size.width * 0.61, size.height * 0.57);
    pos1 = Offset(size.width / 2 - tam1.dx / 2, size.height * 0.57 * 0.2);
    pos2 = Offset(0, size.height * 0.57 * 0.4 / 3);
    pos3 = Offset(size.width / 3, 0);
    pos4 = Offset(size.width / 3 * 2, size.height * 0.57 * 0.4 / 3);
    if (tipo == 2) {
      TamTableros = [[tam1.dx, tam1.dy], [tam2.dx, tam2.dy]];
      PosTableros = [[pos1.dx, pos1.dy], [pos3.dx, pos3.dy]];
    }
    else {
      TamTableros = [
        [tam1.dx, tam1.dy],
        [tam2.dx, tam2.dy],
        [tam2.dx, tam2.dy],
        [tam2.dx, tam2.dy]
      ];
      PosTableros = [
        [pos1.dx, pos1.dy],
        [pos2.dx, pos2.dy],
        [pos3.dx, pos3.dy],
        [pos4.dx, pos4.dy]
      ];
    }
    //////////////////////////////////////
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarRecursos();}

 //Cargar imagenes en cache
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
  ///////////////////////////

  @override
  Widget build(BuildContext context) {
    //SetState para obtener el tamaño de la pantalla
    setState(() {
      size= MediaQuery.of(context).size;
    });
    return WillPopScope(
      //WillPop para impedir que se salga del juego cuando se quiere hacer un Navigator.pop
          onWillPop: ()async{
            return false;
          },
        //BLocProvider para el Bloc de Game
          child:BlocProvider(
      create: (context2)=>GameBloc(GameRepo()),
      child: Scaffold(
        //StreamBulder para obtener la informacion de la Sala Actual
          body: StreamBuilder(
            stream: Firestore.instance.collection("Salas").document(idSala).snapshots(),
            builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
              //Verifica si ya se cargaron los datos desde la base de datos
              if(!snapshot.hasData){return Carga(2,width: size.width,height: size.height);}
              else{
                //BlocBuilder para obtner los estados del GameBloc
                return BlocBuilder<GameBloc,GameState>(
                    builder: (context2,state){
                      //Verifica si esta en el estado inicial
                      if(state is GameInit){
                        BlocProvider.of<GameBloc>(context).add(IniciarJugada(size,tipo));

                        return Carga(2,width: size.width,height: size.height);
                      }
                      else {
                        //Verifica que el juego esta Cargado
                        if (state is GameLoaded) {
                          stateL = state.game;
                          if(crono==null){
                                myCallback((){
                                  setState(() {
                                    crono=90;
                                  });
                                  if(snapshot.data.data["arrayP"][snapshot.data.data["turno"]] == id)
                                    cronometro(context, true);
                                  else cronometro(context, false);
                                });
                          }
                        }
                        if(state is GameLoadingCrono){
                          stateL=state.game;
                        }
                        //Verifica que el juego esta cargandose
                        else if (state is GameLoading) {
                          stateL = state.game;
                        }

                        //verifica si cambio el turno en la partida
                        if (snapshot.data.data['turno'] != stateL.turno) {
                          myCallback(() async{
                            moverTablas(500,context2,snapshot);
                            setState(() {
                              //Mueve las Tablas y cambia el turno al siguiente
                              BlocProvider.of<GameBloc>(context).add(
                                  Turno(snapshot.data.data['turno']));
                            });
                          });
                        }

                        //Verifica si es nuestro turno en la partida
                        if (snapshot.data.data['ganador'] == ""
                            && id ==snapshot.data.data['arrayP'][snapshot.data.data['turno']] && stateL.paso == 0)
                        {
                          myCallback(() {
                            BlocProvider.of<GameBloc>(context).add(
                                CargandoDesac());
                            BlocProvider.of<GameBloc>(context).add(Paso1());
                          });
                        }
                        else {
                          //Pone nuestro juego en paso0 Para que no se pueda
                          //realizar ningun movimiento
                          if (id != snapshot.data.data['arrayP'][snapshot.data
                              .data['turno']] && stateL.paso != 0) {
                            myCallback(() {
                              BlocProvider.of<GameBloc>(context).add(Paso0());
                            });
                          }
                        }

                        return Stack(
                            children: [
                              //verifica que la partida este activa
                              snapshot.data.data["encendido"] ?
                              //Scaffold principal de la pantalla
                              Scaffold(
                                  body: Column(
                                    children: <Widget>[
                                      Container(
                                          height: size.height * 0.65,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/recursos/mesa3.jpg"
                                                  ), fit: BoxFit.cover
                                              )
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                color: Colors.black.withOpacity(
                                                    0.3),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  //Espacio superior en la pantalla
                                                  SizedBox(
                                                    height: size.height * 0.04,
                                                    width: size.width
                                                  ),
                                                  //Panel Principal donde estan los paneles de puntuacion
                                                  Container(
                                                      height: size.height *
                                                          0.61,
                                                      width: size.width,
                                                      child:
                                                      //Stream builder para acceder a los datos
                                                      //de los jugadores en la partida
                                                      StreamBuilder(
                                                        stream: Firestore
                                                            .instance
                                                            .collection("Salas")
                                                            .document(idSala)
                                                            .collection(
                                                            "jugadores")
                                                            .orderBy("time")
                                                            .snapshots(),
                                                        builder: (
                                                            BuildContext context,snapshot2) {
                                                          //Verifica que exista datos en el snapshot
                                                          if (snapshot2.hasData) {
                                                            List<DocumentSnapshot> items = snapshot2.data.documents;


                                                            Function eq = const ListEquality().equals;


                                                            //Verifica se cambio la jugada del jugador oponente
                                                            //en su turno y la cambia si existe algun cambio
                                                            if(!eq(stateL.lanzamientos1[snapshot.data.data["turno"]]
                                                                ,items[snapshot.data.data["turno"]].data["jugada1"])){
                                                              BlocProvider.of<GameBloc>(context).add(
                                                                  CambiarJugada1(
                                                                  items[snapshot.data.data["turno"]].data["jugada1"]
                                                                  ,snapshot.data.data["turno"]
                                                              ));
                                                            }


                                                            //Stack donde se mueven los tableros de las puntuaciones
                                                            //de todos los jugadores
                                                            return Stack(
                                                              //Map para poder entrar a todas las posiciones
                                                                children: PosTableros.asMap().entries.map((entrie) {
                                                                  return Positioned(
                                                                      top: entrie.value[1],
                                                                      left: entrie.value[0],
                                                                      //Tablero de un jugador
                                                                      child: TableroAnotacion(
                                                                        size,
                                                                        entrie.key,
                                                                        items[entrie.key].data['puntuacion'],
                                                                        TamTableros[entrie.key][0],
                                                                        TamTableros[entrie.key][1],
                                                                        items[entrie.key].data['nombre'],colorRiva[entrie.key])
                                                                  );
                                                                }).toList());
                                                          }
                                                          else {
                                                            //Esto se llama cuando estan cargando los datos
                                                            return Carga(2,
                                                                height: size.height *0.61,
                                                                width: size.width
                                                            );
                                                          }
                                                        },
                                                      )

                                                  )
                                                ],
                                              ),
                                              //Pregunta si esta apretado el boton de ayuda
                                              //y muestra la ayuda cuando este es true
                                              stateL.ayuda ? Container(
                                                height: size.height * 0.65,
                                                width: size.width,
                                                child: stateL.paso!=5?stateL.ayudas[stateL.paso]:stateL.ayudas[3],
                                              ) : Container(),


                                              //Boton de ayuda ubicado en el panel principal
                                              Positioned(
                                                bottom: size.width * 0.05,
                                                right: size.width * 0.05,
                                                child: Container(
                                                  width: size.width * 0.1,
                                                  height: size.width * 0.1,
                                                  child: IconButton(
                                                    iconSize: size.width * 0.1,
                                                    icon: Icon(Icons.help),
                                                    color: color6,
                                                    onPressed: () {
                                                      setState(() {
                                                        if(snapshot.data
                                                            .data["arrayP"][snapshot.data
                                                            .data["turno"]] == id){BlocProvider.of<
                                                            GameBloc>(context)
                                                            .add(Ayuda());}
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              //Este es el cronometro
                                              Align(
                                                alignment: Alignment(-0.94, 0.94),
                                                child: Text(crono.toString()
                                                  ,style: TextStyle(color: crono==null?color6:crono<10?Colors.red:crono<20?Colors.amber:color6,fontSize: size.height*0.035),),
                                              ),


                                            ],
                                          )
                                      ),
                                      //Segundo panel ubicado en la parte inferior
                                      Container(
                                        width: size.width,
                                        height: size.height * 0.35,
                                        child: Stack(
                                            children: [
                                              //Panel principal Inferior
                                              Container(
                                                width: size.width,
                                                height: size.height * 0.35,

                                                  //Fondo Verde OScuro con textura del panel inferior
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: color2,width: 3),
                                                    color: color7.withOpacity(0.5),
                                                    image: DecorationImage(
                                                        colorFilter: ColorFilter.mode(
                                                            Color(0xff108BF1),
                                                            BlendMode.colorBurn),
                                                        image: AssetImage("assets/images/tablero_1.jpg"),
                                                        fit: BoxFit.cover
                                                    )),

                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                        height: size.height *0.29 - 6,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: size.width * 0.7 -6,
                                                              child:
                                                              Center(
                                                                child:
                                                                    //Pregunta si es un tablero normal
                                                                //O un tablero que muestra las jugadas del oponente
                                                                snapshot.data.data["arrayP"][snapshot.data.data["turno"]] == id

                                                                //Tablero normal del jugador en su turno
                                                                    ?TableLanza(
                                                                    size.width *0.6,
                                                                    (size.height *0.29 -6) *0.7,
                                                                    dadosImg,
                                                                    _animation,
                                                                    _animationVolteo)

                                                                //Tablero para las jugadas del oponenete
                                                                    :TableLanzaOponente(
                                                                    size.width *0.6,
                                                                    (size.height *0.29 -6) *0.7,
                                                                    dadosImg,
                                                                    _animation,
                                                                    _animationVolteo,
                                                                    snapshot.data.data["turno"]
                                                                    ),

                                                              ),
                                                            ),

                                                            //Lanzador "CACHO"
                                                            Container(
                                                                width: size.width *0.3,
                                                                child: Center(
                                                                  child: Lanzador(
                                                                      size.width *0.3,
                                                                      (size.height *0.29 -6) *0.5,idSala),
                                                                )
                                                            )


                                                          ],
                                                        )
                                                    ),
                                                    stateL.paso == 1 ||stateL.paso == 2 ||stateL.paso == 0
                                                    //Barra inferior de dados que solo se muestra en los pasos
                                                    //0,1,2
                                                        ? Container(
                                                      padding: EdgeInsets.all(size.height * 0.01),
                                                      height: size.height *0.06,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: color7),
                                                        borderRadius: BorderRadius.circular(size.height * 0.06 *0.2),
                                                        image: DecorationImage(
                                                            colorFilter: ColorFilter.mode(color3,BlendMode.color),
                                                            image: AssetImage("assets/images/tablero_1.jpg"),
                                                            fit: BoxFit.cover
                                                        ),
                                                      ),
                                                      child: DadosBloqueados(
                                                          size.height * 0.04 *5 + size.height *0.01 * 4,
                                                          size.height * 0.04,
                                                          dadosImg),
                                                    )

                                                    //Cuando los pasos estan en 3 y 5 se muestra un boton siguiente
                                                    : stateL.paso == 3 ||stateL.paso == 5
                                                    ? BotonSiguiente(
                                                    size.height * 0.04 * 5 +size.height * 0.01 *4,
                                                    size.height * 0.06,
                                                    color5, "Siguiente",idSala)

                                                    //Si esta en el Paso final muestra un lugar para
                                                    //seleccionar la jugada y un boton de anotar
                                                    : SelecJugada(
                                                    size.width * 0.8,
                                                    size.height * 0.06,
                                                    Colors.blueGrey,
                                                    jugadas, idSala)


                                                  ],
                                                )
                                            ),

                                              //En esta parte se muestran los WIdgets de Cargando cuando
                                              //ocurre un evento asyncrono o no se esta en nuestro turno
                                              (stateL.cargando&&snapshot.data.data["arrayP"][snapshot.data.data["turno"]] == id)
                                                  ||(state is GameLoading && (stateL.paso==3||stateL.paso==4))

                                              //Aqui se muestra el reloj de arena como simbolo de espera
                                              //o los 3 puntos dependiendo del caso
                                                  ?Container(
                                                  width: size.width,
                                                  height: size.height * 0.35,
                                                  color: color7.withOpacity(0.6),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        width: size.width,
                                                        height: size.height *0.25,
                                                        //Aqui se pregunta si es una espera de subir tu jugada
                                                        child: (state is GameLoading && (stateL.paso==3||stateL.paso==4))

                                                        //Si es una espera de subir tu jugada es un simbolo de 3 puntos
                                                             ?Center(
                                                              child: Carga(2,
                                                              width: size.width *0.2,
                                                              height: size.height *0.1)
                                                              //carga(size.width*0.3, size.height*0.15)
                                                              )

                                                        //Si es una carga normal es el simbolo de reloj de arena
                                                            :Center(
                                                            child: Carga(1,
                                                                width: size.width *0.3,
                                                                height: size.height *0.15)
                                                          //carga(size.width*0.3, size.height*0.15)
                                                        )

                                                        )

                                                    ],
                                                  )
                                              ):
                                              //Este Widget se muestra cuando es el turno de tu oponente
                                              //Se oscurece la pantalla y se muestra un reloj de arena con la letenda:
                                              //'Esperando a tu oponente'.(No se oscurece mucho de tal manera
                                              // que puedes ver aun los movimientos de tu oponente)
                                              (snapshot.data.data["arrayP"][snapshot.data.data["turno"]] != id)
                                                ?Container(
                                                  width: size.width,
                                                  height: size.height * 0.35,
                                                  color: color7.withOpacity(
                                                      0.3),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .end,
                                                    children: <Widget>[
                                                      Container(
                                                        width: size.width,
                                                        height: size.height *
                                                            0.08,
                                                        child: Center(
                                                            child: Carga(1,
                                                                width: size.width *0.25,
                                                                height: size.height *0.1)
                                                          //carga(size.width*0.3, size.height*0.15)
                                                        ),
                                                      ),
                                                      Container(height: size.height*0.035,child: Text(
                                                          'Esperando a tu oponente',style: TextStyle(
                                                          fontSize: size.height*0.02,color: color6.withOpacity(0.9),
                                                          fontFamily: 'CenturyGothic'),),)
                                                    ],
                                                  )
                                              )
                                              //Returna un container vacio por que es nuestro turno y no hay nigun simbolo de espera
                                              :Container()
                                            ]),
                                      )
                                    ],
                                  ),
                                )
                              //Carga cuando aun no se cargaron los datos de la base de datos
                              : Carga(2,height: size.height,width: size.width,),
                              //Muesta la pantalla de ganador cuando ve que en la base de datos esta
                              //el ganador anotado
                              snapshot.data.data["ganador"] == ""
                                  ? Container()
                              //Pantalla de cuando termina una partida y hay un ganador
                                  : Terminado(size.width, size.height, snapshot
                                  .data.data["ganador"], snapshot.data
                                  .data["arrayP"][snapshot.data.data["turno"]],id,size)
                            ]);
                      }
                    },
                  );
              }
            },
          )
        ),
      )
    );
  }

  //Funcion para mover las tablas utilzando Hilos
  Future moverTablas(duracion,context,snapshot)async{
    setState(() {
      mover=true;
    });
    BlocProvider.of<GameBloc>(context).add(Paso0());
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

      await Future.delayed(Duration(microseconds: 5));
    }

    setState(() {
      mover=false;
      crono=80;
    });
    if(snapshot.data.data["arrayP"][snapshot.data.data["turno"]] == id)
    cronometro(context,true);
    else
      cronometro(context,false);


  }
  //Aqui se llama al hilo del cronometro dependiendo del tipo de jugador
  cronometro(context,tipo)async {
    if(tipo){
      if(!(stateL.cargando&&stateL.paso==4)){
        setState(() {
          crono--;
        });
        if(crono>0){
          await Future.delayed(Duration(seconds: 1));
          cronometro(context,tipo);
        }
        else{
          await FuncionesJuegos().subirPuntaje(null, 1, idSala);
          BlocProvider.of<GameBloc>(context).add(IniciarDeNuevo());
          setState(() {
            crono=80;
          });
        }
      }
    }
    else{
      if(stateL.cargando||stateL.paso==0){
        setState(() {
          crono--;
        });
        if(crono>0){
          await Future.delayed(Duration(seconds: 1));
          cronometro(context,tipo);
        }
      }
    }
  }
  //CallBaCK Para llamar a una funcion dentro del StreamBuilder
   void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });

    //Temporizador

  }


}








