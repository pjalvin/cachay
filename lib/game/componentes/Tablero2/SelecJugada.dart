import 'package:cachay/game/bloc/bloc.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/DadoNormal.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/Dados.dart';
import 'package:cachay/game/componentes/Tablero2/Finalizar.dart';
import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/animation.dart' as animation;

class SelecJugada extends StatelessWidget {
  double width,height;
  Game state2;
  Color color;
  List<String> jugadas;
  String idSala;
  SelecJugada(this.width,this.height,this.color,this.jugadas,this.idSala);
  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<GameBloc,GameState>(
        builder: (context,state){

          if(state is GameLoadingCrono){
            state2=state.game;
          }
          if(state is GameLoaded){
            state2=state.game;
          }
          else if(state is GameLoading){
            state2=state.game;
          }
          else if(state is GameLoading2){
            state2=state.game;
          }
          print("grupos est este${state2.grupos}");
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

                                  BlocProvider.of<GameBloc>(context).add(CambiarCombo(changedValue));
                                },
                                value: state2.ValorDrop,
                                items:
                                state2.grupos.map((value) {
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
                  Finalizar(width, height, color, "Anotar",context,jugadas,idSala)

                ],
              )
          );
        },
      );
  }

}
