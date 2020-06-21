import 'dart:ui';
import 'package:flame/animation.dart' as animation;
import 'package:flutter/material.dart';

import '../../main.dart';
class Game {

  //recursos
  bool ayuda=false;
  Size size;
  animation.Animation _animation;
  animation.Animation _animationVolteo;
  var colorRiva = [color5,Colors.green, Color(0xffFA7659), Colors.lightBlueAccent];
  int paso = 0;
  List<List<double>> PosTableros;
  List<List<double>> TamTableros;
  Offset pos1,pos2,pos3,pos4;
  Offset tam1,tam2;
  int turno=0;
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
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];
  List<String> nombRiva = ["Alvin", "Juan", "Pedro", "Luis"];
  List<Widget> ayudas ;
}