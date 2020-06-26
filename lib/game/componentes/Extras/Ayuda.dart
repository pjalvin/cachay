import 'package:cachay/main.dart';
import 'package:flutter/material.dart';
class Ayudas {
  Widget Ayuda1(width,heigth){
    return _AyudaBase(color6, ""
        "Paso 1: Toca el Vaso"
        " para poder"
        " Girar los dados.",width,heigth);
  }

  Widget Ayuda2(width,heigth){
    return _AyudaBase(Color(0xff3663FC),
        "Paso 2: Toca nuevamente el vaso"
        " para realizar tu segundo lanzamiento"
        " o selecciona los dados"
        " para poder bloquearlos.",width,heigth);
  }

  Widget Ayuda3(width,heigth){
    return _AyudaBase(Color(0xff29E3CC),
        "Paso 3: Toca un dado para voltearlo"
        " (Son solo 2 volteos. Recuerda que se debe dar una vuelta obligatoria"
        " la segunda es opcional)"
        " Apretar en 'Siguiente' para continuar.",width,heigth);
  }

  Widget Ayuda4(width,heigth){
    return _AyudaBase(color5,
        "Paso 4: Escoje los dados para realizar tu jugada."
            " El tipo de lanzamiento ira apareciendo en la lista"
            " mientras lo vayas armando"
            ". Apreta 'Anotar' para enviarlo",width,heigth);
  }
  Widget _AyudaBase(color,text,width,height){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Container(
            height: height * 0.65*0.3,
            width: width,
            decoration: BoxDecoration(
                border: Border.all(color: color2, width: 3),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xffFF7800).withOpacity(0.85), BlendMode.dstATop),
                    image: AssetImage("assets/images/tablero_3.jpg"),
                    fit: BoxFit.cover
                ),
            ),
            padding: EdgeInsets.only(left:height*0.02,right:height*0.02,bottom:height*0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Text(text,textAlign: TextAlign.center,
                  style:TextStyle(color: color7,fontSize: height*0.025,fontFamily: 'CenturyGothic')),],
            )
          )]
        ),
      );
  }
}