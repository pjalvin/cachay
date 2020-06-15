import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
class Ayudas {
  Widget Ayuda1(){
    return _AyudaBase(color6, ""
        "Toca el Vaso"
        "para poder"
        "Girar los dados.");
  }

  Widget Ayuda2(){
    return _AyudaBase(color6,
        "Toca nuevamente el vaso"
        "para realizar tu segundo lanzamiento"
        "o selecciona los dados"
        "para poder bloquearlos.");
  }

  Widget Ayuda3(){
    return _AyudaBase(color6,
        "Toca un dado para voltearlo"
        "(Son solo 2 volteos. Recuerda que se debe dar una vuelta obligatoria"
        "la segunda es opcional)"
        "Apretar en 'Siguiente' para continuar.");
  }

  Widget Ayuda4(){
    return _AyudaBase(color6,
        "Escoje los dados para realizar tu jugada."
            "El tipo de lanzamiento ira apareciendo en el boton"
            "mientras lo vayas armando"
            ". Apreta el boton para enviarlo");
  }
  Widget _AyudaBase(color,text){
    return Expanded(

      child: Container(
        color: color7.withOpacity(0.8),
        child: Center(
          child: Text(text,
              style:TextStyle(color: color,fontSize: 18)),
        ),
      ),
    );
  }
}