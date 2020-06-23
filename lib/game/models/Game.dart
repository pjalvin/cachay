import 'dart:ui';
import 'package:flame/animation.dart' as animation;
import 'package:flutter/material.dart';

import '../../main.dart';
class Game {

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

  //////////////////////////////



  //Jugadas
  int cantDado=0;
  List grupos=[];
  String ValorDrop;
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
      this.ayudas
      );
}