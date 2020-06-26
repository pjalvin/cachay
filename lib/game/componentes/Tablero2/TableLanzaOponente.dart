import 'package:cachay/game/bloc/bloc.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/DadoNormal.dart';
import 'package:cachay/game/componentes/Tablero2/Dados/Dados.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/animation.dart' as animation;

class TableLanzaOponente extends StatelessWidget {
  double width,height;
  Game state2;
  animation.Animation _animation,_animationVolteo;
  int oponente;
  var imagenes;
  TableLanzaOponente(this.width,this.height,this.imagenes,this._animation,this._animationVolteo,this.oponente);
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

          return Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(width * 0.05),
            child: Container(
                width: width,
                height: height,
                padding: EdgeInsets.all(height * 0.05),
                decoration: BoxDecoration(
                    border: Border.all(color: color2, width: 3),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color(0xff8F0A0F), BlendMode.color),
                        image: AssetImage("assets/images/tablero_1.jpg"),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(width * 0.05)
                ),
                child:
                Center(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),

                    crossAxisCount: 3,
                    crossAxisSpacing: ((width - 6 - height * 0.1) -
                        3 * height * 0.4) / 2,
                    children:
                    state2.lanzamientos1[oponente].asMap().entries.map((data){
                      return
                      state is GameLoading
                          ? Dados().dadoGira(height * 0.4, height * 0.4,1,_animation,_animationVolteo)
                          : DadoNormal(height * 0.4,data.value,imagenes, "oponente",  data.key,1);
                    }).toList()
                  ),
                )
            ),
          );
        },
      );
  }
}
