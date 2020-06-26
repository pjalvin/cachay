import 'package:cachay/game/bloc/bloc.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/Dados.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Clase para controlar un dado normal
class DadoNormal extends StatelessWidget {
  double width,height;
  int numero;
  var dadosImg;
  String tipo;
  Game state2;
  int i;
  int tipocolor;
  DadoNormal(this.width,this.numero,this.dadosImg,this.tipo,this.i,this.tipocolor);
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

                      print(state2.paso);
                      switch (tipo) {

                        case "lanza":
                          switch (state2.paso) {
                            case 1:
                              break;
                            case 2:
                              BlocProvider.of<GameBloc>(context).add(Intercambiar1(i));

                              break;
                            case 3:
                              BlocProvider.of<GameBloc>(context).add(VoltearDados(i));
                              print(state2.dados);
                              break;
                            case 4:
                              BlocProvider.of<GameBloc>(context).add(DeterminarGrupo(i));
                              print(state2.grupos);
                              break;
                          }
                          break;
                        case "bloqueo":
                          switch (state2.paso) {
                            case 1:
                              break;
                            case 2:
                              BlocProvider.of<GameBloc>(context).add(Intercambiar2(i));
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
        },
      );
  }

}
