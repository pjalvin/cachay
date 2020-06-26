

import 'dart:async';
import 'dart:math';

import 'package:cachay/game/componentes/Extras/Ayuda.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';

abstract class GameRepository {
  //Aqui se definen las funciones que se usaran en el bloc
  Game obtenerGame();
  Game cargandoAct();
  Game cargandoDesac();
  Game turno(turno);
 Game getGame(size,tipo);
 Game aumentarPaso();
 Game ayuda();
 Future<Game> lanzarDados1();
 Future<Game> lanzarDados2();
 Game moverDadospaso3();
 Game intercambiarDados1(i);
  Game intercambiarDados2(i);
  Game paso1();
  Game paso0();
  Game volteoIni(i);
  Game subirPaso4();
  Future<Game> volteoDados(i);
  Game cambiarCombo(valor);
  Game agruparDadosAnotar(i);
  Game actualizarPuntuacion(puntuacion);
  Game iniciarJugada();
  Game cambiarJugada1(List<dynamic> jugada,i);
  Game cambiarJugada2(List<dynamic> jugada,i);
  Future<Game> aumentarTempo();
}
//Repositorio Para poder obtener la infromacion de mi juego asi como los
//atributos y sus funciones
class GameRepo implements GameRepository{

  Game game;
  List<String> jugadas=["Balas","Tontos","Trenes",
    "Cuadras","Quinas","Senas",
    "Escalera","Full","Poker","Grande"];
  GameRepo();

  //Funcion para poder instanciar mi juego la primera vez y cargar los datos
  @override
  Game getGame(size,tipo){
    var TamTableros;
    var PosTableros;

    var ayudas= [Container(),
      Ayudas().Ayuda1(size.width,size.height),
      Ayudas().Ayuda2(size.width,size.height),
      Ayudas().Ayuda3(size.width,size.height),
      Ayudas().Ayuda4(size.width,size.height)
    ];

    var tam2=Offset(size.width/3, size.height * 0.57 / 3);
    var tam1=Offset(size.width * 0.61,size.height * 0.57);
    var pos1=Offset(size.width/2-tam1.dx/2,size.height * 0.57*0.2);
    var pos2=Offset(0, size.height * 0.57*0.4 / 3);
    var pos3=Offset(size.width/3,0);
    var pos4=Offset(size.width/3*2,size.height * 0.57*0.4 / 3);
    if(tipo==2){
      TamTableros=[[tam1.dx,tam1.dy],[tam2.dx,tam2.dy]];
      PosTableros=[[pos1.dx,pos1.dy],[pos3.dx,pos3.dy]];}
    else{
      TamTableros=[[tam1.dx,tam1.dy],[tam2.dx,tam2.dy],[tam2.dx,tam2.dy],[tam2.dx,tam2.dy]];
      PosTableros=[[pos1.dx,pos1.dy],[pos2.dx,pos2.dy],[pos3.dx,pos3.dy],[pos4.dx,pos4.dy]];}


    game=Game(PosTableros,TamTableros,ayudas,tam1,tam2,pos1,pos2,pos3,pos4);
    return game;
  }



  //Funciones Generales que se utilizan en muchos casos


  //Actualiza la puntuacion que se tiene actualmentte
  actualizarPuntuacion(puntuacion){
    game.puntuaciones=puntuacion;
    return game;
  }
  //actualiza la jugada en el primer panel que esta haciendo el contrario
  cambiarJugada1(List<dynamic> jugada,i){
    game.lanzamientos1[i]=jugada;
    return game;
  }
  //actualiza la jugada en el segundo panel que esta haciendo el contrario
  cambiarJugada2(List<dynamic> jugada,i){
    game.lanzamientos2[i]=jugada;
    return game;
  }

  //inicia nuevamente una jugada cuando es nuestro turno
  aumentarTempo()async{
    game.estadoTempo--;
    await Future.delayed(Duration(seconds: 1));
    return game;
  }
  iniciarJugada() {
    game.estadoTempo=60;
    game.paso = 0;
    game.bloqLanzador = false;
    game.apretarCacho = false;
    game.bloqueoVolteos=0;
    game.contadorTiros=0;
    game.contadorVolteos=0;
    game.dados = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0]];
    game.dadosRetenidos = [];
    game.dadosAnotar=[];
    game.grupos=[];
    game.ValorDrop=null;
    return game;
  }

  //devuelve e3l estado actual de game
  obtenerGame(){
    return game;
  }
  //activa el estado cargando
  cargandoAct(){
    game.cargando=true;
    return game;
  }
  //desactiva el estado cargando
  cargandoDesac(){
    game.cargando=false;
    return game;
  }
  //cambia el turno actual de la partida
  turno(turno){
    game.turno=turno;
    return game;
  }
  //aumenta el paso en el que se encuentra nuestra jugada
  @override
  aumentarPaso(){
    game.paso++;
    return game;
  }
  //pone nuestra jugada en paso 0 de esta manera no se puede realizar ningun movimiento
  paso0(){
    game.paso=0;
    return game;
  }
  //pone nuestra jugada en el paso 1
  paso1(){
    game.paso=1;
  return game;}
  //cambia el valor para activar o descativar la ayuda en pantalla
  @override
  ayuda(){
    game.ayuda=!game.ayuda;
    return game;
  }
  //hilo para simular el lanzamiento de un dado
  Future esperarlanzamiento() async {
    await Future.delayed(Duration(milliseconds: 1000));
    random();
  }
  //funcion para poder sacar randomicamente el valor del numero de los dados en un lanzamiento
  random(){
    int c = 0;
    game.dados.forEach((val) {
      val[1] = 0;
      val[0] = 1+Random().nextInt(6);
      print(val[0]);
      game.bloqLanzador = false;
      c++;
    });
  }
  //////////////////////////////////////////////////////





  //Funciones para el primer paso en una jugada
  //Hilo para poder lanzar los dados la primera vez
  Future<Game> lanzarDados1()async{
      game.apretarCacho = !game.apretarCacho;
      game.dados.forEach((val) {
        val[1] = 1;
      });
      game.bloqLanzador = !game.bloqLanzador;
    await esperarlanzamiento();
    await Future.delayed(Duration(milliseconds: 100));
    game.contadorTiros++;
    return game;
  }
  /////////////////////////////////////////////







  //Funciones para el segundo paso
  //Hilo para poder lanzar los dados la segunda  vez
  Future<Game> lanzarDados2() async {
    game.apretarCacho = !game.apretarCacho;
    game.dados.forEach((val) {
      val[1] = 1;
    });
    game.bloqLanzador = !game.bloqLanzador;
    await esperarlanzamiento();
    await Future.delayed(Duration(milliseconds: 100));
    game.apretarCacho = !game.apretarCacho;
    return game;
  }
  //Ordena los dados para que se encuentren solo en el apartado del tablero principal
  moverDadospaso3(){
    if(game.paso==2){
      for(int i=0;i<game.dadosRetenidos.length;i++){
          game.dados.add(game.dadosRetenidos[i]);
      }
        game.dadosRetenidos.clear();
    }
    return game;
  }
  //////////////////////////////



  //Funciones para el paso 3
  //intercabia los dados del tablero principal al tablero secundario de bloqueo
  intercambiarDados1(i) {
     if(game.dados[i][0] != 0)
      game.dadosRetenidos.add(game.dados[i]);
      game.dados.removeAt(i);
      return game;
  }
  //intercabia los dados del tablero de secundario de bloqueo al tablero principal
  intercambiarDados2(i) {
      game.dados.add(game.dadosRetenidos[i]);
      game.dadosRetenidos.removeAt(i);
      return game;
  }
  //hilo que simula el volteo de un dado
  Future esperarVolteo(i)async {
    await Future.delayed(Duration(milliseconds: 100));
        game.dados[i][0]=7-game.dados[i][0];
        game.dados[i][1]=0;
        game.paso=3;
        game.bloqueoVolteos++;
  }
  //Funcion que pone un dado en espera de un volteo
  volteoIni(i){
    game.dados[i][1]=2;
    return game;
  }
  //Funcion para voltear un dado
  volteoDados(i)async{
    if(game.paso==3&&game.bloqueoVolteos<2){
        game.paso=5;
      await esperarVolteo(i);
      return game;
    }
    else{
      print("bloqueado");
      return game;
    }
  }
  //Funcion para el boton 'siguiente' que pone el paso actual en 4
  subirPaso4(){
    game.paso=4;
    return game;
  }
  ///////////////////////////////////





  //Funciones para el ultimo paso de una jugada
  //Cambia el valor de  un comboBox dependiendo de la opcion que se eliga
  cambiarCombo(valor){
    game.ValorDrop=valor;
    return game;
  }
  //funcion para poder determinar el grupo y anotar el valor en el comobox
  agruparDadosAnotar(i){
    if(game.paso==4){
      if(!game.dadosAnotar.asMap().containsValue(i)){
          game.dadosAnotar.add(i);
          game.dados[i][1]=3;
          game.grupos=detGrupo();
          if(game.grupos.length>0){
            game.ValorDrop=game.grupos[0][0]!=0?game.grupos[0][0].toString()+" "+jugadas[game.grupos[0][1]]:jugadas[game.grupos[0][1]];
          }
      }
      else{
          game.dadosAnotar.remove(i);
          game.dados[i][1]=0;
          game.grupos=detGrupo();
          if(game.grupos.length>0){
            game.ValorDrop=game.grupos[0][0]!=0?game.grupos[0][0].toString()+" "+jugadas[game.grupos[0][1]]:jugadas[game.grupos[0][1]];
          }
      }
    }
    return game;
  }
  //Verifica la disponibildad de un grupo
  verificarDispo(i){
    if(game.puntuaciones[0][i]>0){
      return false;
    }
    else{
      return true;
    }
  }

  //verifica las jugadas que forman un grupo de dados
  List<List<int>>detGrupo(){
    List<List<int>> retornoTipos=List();
    if(game.dadosAnotar.length==0){
      return retornoTipos;
    }
    else{
      int vernumEsp=0;
      int vernumEsp2=0;
      bool verinumnorm=true;

      for(int i=0;i<game.dadosAnotar.length;i++){
        if(game.dados[game.dadosAnotar[i]][0]==game.dados[game.dadosAnotar[0]][0]){
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
        retornoTipos.add([vernumEsp,game.dados[game.dadosAnotar[0]][0]-1]);
      }
      if((vernumEsp==3&&vernumEsp2==2)||(vernumEsp==2&&vernumEsp2==3)){
        retornoTipos.add([0,7]);
      }
      if((vernumEsp==4||vernumEsp2==4)&&(vernumEsp+vernumEsp2!=5)){
        retornoTipos.add([0,8]);
      }
      if(game.dadosAnotar.length==5){
        if(verificarEscalera()){
          retornoTipos.add([0,6]);
        }
      }

      return retornoTipos;
    }

  }
  //verifica si una jugada es una escalera
  verificarEscalera(){
    List<int> numeroDados=List();
    for(int i=0;i<game.dadosAnotar.length;i++){
      numeroDados.add(game.dados[game.dadosAnotar[i]][0]);
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
      if(numeroDados[0]==1&&numeroDados[1]==3){
        print("escalera 3");
        int c=1;
        for(int i=3;i<=6;i++){
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
          bien=false;
        }
      }
    }
    return bien;
  }
  //////////////////////////////






}