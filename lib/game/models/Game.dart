import 'dart:ui';
import 'package:flame/animation.dart' as animation;
import 'package:flutter/material.dart';

import '../../main.dart';
class Game {

  var tam2,tam1;
  var pos1,pos2,pos3,pos4;
  //recursos
  bool ayuda=false;
  int paso = 0;
  List<List<double>> PosTableros;
  List<List<double>> TamTableros;
  int turno=0;
  ///////////////////////////


  //bloqueos de objetos
  bool bloqLanzador = false;
  bool apretarCacho = false;
  bool cargando = true;
  int bloqueoVolteos=0;
  int contadorTiros=0;
  int contadorVolteos=0;
  int estadoTempo=60;

  //////////////////////////////



  //Jugadas
  int cantDado=0;
  List grupos=[];
  String ValorDrop;
  List<List<dynamic>> lanzamientos1 = [
    [0, 0, 0, 0, 0, ],
    [0, 0, 0, 0, 0, ],
    [0, 0, 0, 0, 0, ],
    [0, 0, 0, 0, 0, ]
  ];

  List<List<dynamic>> lanzamientos2 = [
    [],
    [],
    [],
    []
  ];
  List<List<dynamic>> puntuaciones = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];
  /////////////////////



  //dados
  List dados = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0]];
  List dadosRetenidos = [];
  List dadosAnotar=[];
  /////////////////////////


  //informacion de la partida

  List<Widget> ayudas ;
  Game(
      this.PosTableros,
      this.TamTableros,
      this.ayudas,
      this.tam1,
      this.tam2,
      this.pos1,
      this.pos2,
      this.pos3,
      this.pos4
      );
}