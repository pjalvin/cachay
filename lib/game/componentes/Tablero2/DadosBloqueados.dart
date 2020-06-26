import 'package:cachay/game/bloc/bloc.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/DadoNormal.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/Dados.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/animation.dart' as animation;

class DadosBloqueados extends StatelessWidget {
  double width,height;
  Game state2;
  var imagenes;
  DadosBloqueados(this.width,this.height,this.imagenes);
  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<GameBloc,GameState>(
        builder: (context,state){
          if(state is GameLoaded){
            state2=state.game;
          }
          if(state is GameLoadingCrono){
            state2=state.game;
          }
          else if(state is GameLoading){
            state2=state.game;
          }
          else if(state is GameLoading2){
            state2=state.game;
          }

          return Container(
              width: width,
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: state2.dadosRetenidos
                    .asMap()
                    .entries
                    .map((val) {
                  return DadoNormal(width / 5, val.value[0],imagenes, "bloqueo", val.key,1);
                }).toList(),
              )
          );
        },
      );
  }
}
