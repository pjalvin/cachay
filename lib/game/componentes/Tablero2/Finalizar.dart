import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cachay/game/bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Finalizar extends StatelessWidget {
  double width,height;
  Game state2;
  Color color;
  String texto;
  BuildContext context;
  var jugadas;
  String idSala;
  Finalizar(this.width,this.height,this.color,this.texto,this.context,this.jugadas,this.idSala);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc,GameState>(
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
        width: width*0.4,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  color, BlendMode.color),
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
          child: Text(texto,style: TextStyle(color: color6,fontSize: height*0.5,fontFamily: 'CenturyGothic'),),
          onPressed: (){
            switch(state2.paso){
              case 1:
                break;
              case 2:
                break;
              case 3:
                break;
              case 4:
                anotarLanzado(state2.ValorDrop,context,state2);
                break;
            }
          },
        ),
      );
    },
    );


  }
  sacarTipo(String tipo){
    var dev=[0,0];
    String busq=tipo;
    var div=tipo.split(" ");
    if(div.length==2){
      busq=div[1];
      dev[0]=int.parse(div[0]);
    }
    for(int i=0;i<jugadas.length;i++){
      if(jugadas[i]==busq){
        dev[1]=i;
        break;
      }
    }
    return dev;
  }
  anotarLanzado(lanz,context,Game state)async{
    if(state.grupos.length==0){
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Selecciona una jugada",
        backgroundColor: color6.withOpacity(0.5),
        textColor: color7.withOpacity(0.8),
        gravity:ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,);
    }
    else{

      BlocProvider.of<GameBloc>(context).add(CargandoAct());
      var verlan=sacarTipo(lanz);
      if(state.contadorTiros==1&&state.bloqueoVolteos==0){
        await FuncionesJuegos().subirPuntaje(verlan,1,idSala);
      }
      else{
        await FuncionesJuegos().subirPuntaje(verlan,2,idSala);
      }
      BlocProvider.of<GameBloc>(context).add(IniciarDeNuevo());
    }

  }
}
