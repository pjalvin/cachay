

import 'dart:async';
import 'dart:math';

import 'package:cachay/game/componentes/Ayuda.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';

abstract class GameRepository {
 Game getGame(size,tipo);
 Game aumentarPaso();
 Game ayuda();
 Future<Game> lanzarDados1();
 Future<Game> lanzarDados2();
 Game moverDadospaso3();


}
class GameRepo implements GameRepository{
  Game game;
  GameRepo();
  @override
  Game getGame(size,tipo){
    print("Tipo:${tipo}");
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


    game=Game(PosTableros,TamTableros,ayudas);
    return game;
  }
  @override
  aumentarPaso(){
    game.paso++;
    return game;
  }
  @override
  ayuda(){
    game.ayuda=!game.ayuda;
    return game;
  }
  Future<Game> lanzarDados1()async{
      game.apretarCacho = !game.apretarCacho;
      game.dados.forEach((val) {
        val[1] = 1;
      });
      game.bloqLanzador = !game.bloqLanzador;
    await esperarlanzamiento();
    await Future.delayed(Duration(milliseconds: 100));
      game.apretarCacho = !game.apretarCacho;
    game.contadorTiros++;
    return game;
  }
    Future esperarlanzamiento() async {
      await Future.delayed(Duration(milliseconds: 1000));
      random();
    }
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
  moverDadospaso3(){
    if(game.paso==2){
      for(int i=0;i<game.dadosRetenidos.length;i++){
          game.dados.add(game.dadosRetenidos[i]);
      }
        game.dadosRetenidos.clear();
    }
    return game;
  }
}