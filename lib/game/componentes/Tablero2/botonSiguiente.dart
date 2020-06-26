import 'package:cachay/game/bloc/bloc.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/DadoNormal.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/Dados.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/animation.dart' as animation;

class BotonSiguiente extends StatelessWidget {
  double width,height;
  Game state2;
  Color color;
  String texto;
  String idSala;
  BotonSiguiente(this.width,this.height,this.color,this.texto,this.idSala);
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
                switch(state2.paso){
                  case 1:
                    break;
                  case 2:
                    break;
                  case 3:
                    BlocProvider.of<GameBloc>(context).add(SubirPaso4(idSala));

                    break;
                  case 4:
                    break;
                }
              },
            ),
          );
        },
      );
  }
}
