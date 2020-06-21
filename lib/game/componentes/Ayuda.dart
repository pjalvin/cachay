import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
class Ayudas {
  Widget Ayuda1(width,heigth){
    return _AyudaBase(color6, ""
        "Toca el Vaso"
        " para poder"
        " Girar los dados.",width,heigth);
  }

  Widget Ayuda2(width,heigth){
    return _AyudaBase(Color(0xff3663FC),
        "Toca nuevamente el vaso"
        " para realizar tu segundo lanzamiento"
        " o selecciona los dados"
        " para poder bloquearlos.",width,heigth);
  }

  Widget Ayuda3(width,heigth){
    return _AyudaBase(Color(0xff29E3CC),
        "Toca un dado para voltearlo"
        " (Son solo 2 volteos. Recuerda que se debe dar una vuelta obligatoria"
        " la segunda es opcional)"
        " Apretar en 'Siguiente' para continuar.",width,heigth);
  }

  Widget Ayuda4(width,heigth){
    return _AyudaBase(color5,
        "Escoje los dados para realizar tu jugada."
            " El tipo de lanzamiento ira apareciendo en el boton"
            " mientras lo vayas armando"
            ". Apreta el boton para enviarlo",width,heigth);
  }
  Widget _AyudaBase(color,text,width,heigth){
      return Container(
        color: color7.withOpacity(0.9),
        padding: EdgeInsets.all(width*0.1),
        child: Center(
          child: Text(text,
              style:TextStyle(color: color,fontSize: width*0.07)),
        ),
      );
  }
}