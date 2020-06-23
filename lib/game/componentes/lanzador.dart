import 'package:cachay/game/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lanzador extends StatelessWidget {
  double width,height;
  Lanzador(this.width,this.height);
  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<GameBloc,GameState>(
    builder: (context,state){
      if(state is GameLoaded){
        return Container(
            width: state.game.apretarCacho ? width : width * 0.9,
            height: state.game.apretarCacho ? height : height * 0.9,
            child: GestureDetector(

              child: state.game.apretarCacho ? Image.asset(
                "assets/images/cacho2.png", width: width, height: height,) : Image
                  .asset("assets/images/cacho.png", width: width * 0.9,
                height: height * 0.9,),
              onTapDown: (pres) async {
                if (!state.game.bloqLanzador ) {
                  if(state.game.dados.length ==0){
                    BlocProvider.of<GameBloc>(context).add(Pasar3());
                  }
                  else{
                    switch (state.game.paso) {
                      case 1:

                        BlocProvider.of<GameBloc>(context).add(Lanzar1());
                        break;
                      case 2:
                        BlocProvider.of<GameBloc>(context).add(Lanzar2());
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
      }
      else{
        return Container();
      }
    }
    );
  }

}
