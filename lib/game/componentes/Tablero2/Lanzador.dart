import 'package:cachay/game/bloc/bloc.dart';
import 'package:cachay/game/funciones_cloud/Movimientos.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lanzador extends StatelessWidget {
  double width,height;
  Game state2;
  String idSala;
  Lanzador(this.width,this.height,this.idSala);
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
            width: state is GameLoading ? width : width * 0.9,
            height: state is GameLoading ? height : height * 0.9,
            child: GestureDetector(

              child: state is GameLoading? Image.asset(
                "assets/images/cacho2.png", width: width, height: height,) : Image
                  .asset("assets/images/cacho.png", width: width * 0.9,
                height: height * 0.9,),
              onTapDown: (pres) async {
                print(state2.dados.toString());
                if (!(state is GameLoading) ) {
                  if(state2.dados.length ==0){
                    BlocProvider.of<GameBloc>(context).add(Pasar3());
                  }
                  else{
                      print(state2.paso);
                    switch (state2.paso) {
                      case 1:

                        BlocProvider.of<GameBloc>(context).add(Lanzar1(idSala));
                        break;
                      case 2:
                        BlocProvider.of<GameBloc>(context).add(Lanzar2(idSala));
                        break;
                      case 3:
                        break;
                      case 4:
                        break;
                    }
                  }


                }
              },

            )
        );

    },
    );
  }


}
