import 'package:cachay/game/componentes/Tablero1/Panel.dart';
import 'package:cachay/main.dart';
import 'package:flutter/material.dart';

class TableroAnotacion extends StatelessWidget {
  Size size;
  int i;
  Color color;
  var puntua;
  double width,height;
  String nombre;
  TableroAnotacion(this.size,this.i,this.puntua,this.width,this.height,this.nombre,this.color);
  @override
  Widget build(BuildContext context) {
    return  Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center,
            children: [
              Container(
                  height: (height) * 0.15,
                  child: Center(
                    child: Text(

                        nombre,
                        style: TextStyle(
                            color: color6,
                            fontSize: (height) *
                                0.1,
                            fontFamily: 'CenturyGothic')),)
              ),
              Panel().panel(
                  width * 0.8,
                  (height) *
                      0.8,
                  puntua,
                  color3,
                  color2,
                  color6,
                  color,
                  color7)
            ],
          )

      );
  }
}
