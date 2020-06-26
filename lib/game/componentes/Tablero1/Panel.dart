import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Panel{
  Widget recurso2(heigth,width,image,text,posiCorona){
    return
          Container(
            width:width,
            height: heigth,
            child: Center(
              child: Image(image: AssetImage(image),
            ),
          ));
  }
  Widget recurso(heigth,width,image,text,posiCorona){
    return Container(
      height: heigth,
      width: width*0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width:heigth*0.7+posiCorona*heigth*0.08,
            height: image=="assets/recursos/diamante.png"?heigth*0.4+posiCorona*heigth*0.08:heigth*0.7+posiCorona*heigth*0.08,
            child: Center(
              child: Image(image: AssetImage(image),
                width: heigth*0.7+posiCorona*heigth*0.08,
                height: heigth*0.7+posiCorona*heigth*0.08,),
            ),
          ),
          Container(
              width: width,
              height: heigth*0.1,
              child: Center(
                child: image=="assets/recursos/diamante.png"? Text(text,style:TextStyle(fontSize: heigth*0.1)):Text(text+" \u0024",style:TextStyle(fontSize: heigth*0.1)),
              )
          )
        ],
      ),
    );
  }
  Widget botonCon(icon,color,colorico,tam){
    return Container(
      decoration: BoxDecoration(
          color: color,borderRadius: BorderRadius.all(Radius.circular(tam))),
      width: tam,
      height: tam,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Icon(icon,color: colorico,size: tam*0.6,),
        ),
      ),
    );
  }
  Widget panel(width, height, List list, color3, color2, color6, color5,
      color7) {
    return Container(
      width: width > height ? height : width,
      height: width > height ? height : width,
      decoration: BoxDecoration(
          color: color6.withOpacity(0.8),
          borderRadius: BorderRadius.circular(
              width > height ? height * 0.04 : width * 0.04)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width > height ? height : width,
            height: width > height ? (height) / 4 : (width) / 4,
            child: filapanel(
                width > height ? height : width,
                list[0],
                list[6]==1?25:list[6]==2?20:0,
                list[1],
                1,
                color2,
                color6,
                color5,
                color7),
          ),
          Container(
            width: width > height ? height : width,
            height: width > height ? (height) / 4 : (width) / 4,
            child: filapanel(
                width > height ? height : width,
                list[2],
                list[7]==1?35:list[7]==2?30:0,
                list[3],
                1,
                color2,
                color6,
                color5,
                color7),
          ),
          Container(
            width: width > height ? height : width,
            height: width > height ? (height) / 4 : (width) / 4,
            child: filapanel(
                width > height ? height : width,
                list[4],
                list[8]==1?45:list[8]==2?40:0,
                list[5],
                3,
                color2,
                color6,
                color5,
                color7),
          ),
          Container(
            width: width > height ? height : width,
            height: width > height ? (height) / 4 : (width) / 4,
            child: filapanel2(
                width > height ? height : width,
                list[9]==1?50:0,
                list[10]==1?50:0,
                color2,
                color6,
                color5,
                color7),
          ),
        ],
      ),
    );
  }
  Widget filapanel2(width, a, b, color2, color6, color5, color7) {
    width = width;
    return Row(
      children: <Widget>[
        Container(
            width: width / 2,
            height: width / 3,
            decoration: BoxDecoration(
                color: color6.withOpacity(0.3),
                border: Border(right:BorderSide(color: color7, width: 1) )
            ),
            child: Center(
              child: a != 0 ? Text(a.toString(),style: TextStyle(color: color2,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5),) : Text(""),
            )
        ),
        Container(
          width: width / 2,
          height: width / 3,
          decoration: BoxDecoration(
          color: color6.withOpacity(0.3)
          ),
          child: Center(
            child: b != 0 ? Text(b.toString(),style: TextStyle(color: color7,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),),
        )
      ],
    );
  }

  Widget filapanel(width, a, b, c, d, color2, color6, color5, color7) {
    width = width;
    return Row(
      children: <Widget>[
        Container(
            width: width / 3,
            height: width / 3,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: color7, width: 1),
                    bottom: BorderSide(color: color7, width: d == 3 ? 0 : 1))
            ),
            child: Center(
              child: a != 0 ? Text(a.toString(),style: TextStyle(color: color2,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),
            )
        ),
        Container(
          width: width / 3,
          height: width / 3,
          decoration: BoxDecoration(
              color: color5.withOpacity(0.7),
              border: Border(right: BorderSide(color: color7, width: 1),
                  bottom: BorderSide(color: color7, width: d == 3 ? 0 : 1))
          ),
          child: Center(
            child: b != 0 ? Text(b.toString(),style: TextStyle(color: color2,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),),
        ),
        Container(
          width: width / 3,
          height: width / 3,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: color7, width: d == 3 ? 0 : 1))
          ),
          child: Center(
            child: c != 0 ? Text(c.toString(),style: TextStyle(color: color2,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),),
        )
      ],
    );
  }

}