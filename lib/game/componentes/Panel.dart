import 'package:flutter/cupertino.dart';

class Panel{
  Widget panel(width, height, List list, color3, color2, color6, color5,
      color7) {
    return Container(
      width: width > height ? height : width,
      height: width > height ? height : width,
      decoration: BoxDecoration(
          color: color3,
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
                color: color6,
                border: Border.all(color: color2, width: 3)
            ),
            child: Center(
              child: a != 0 ? Text(a.toString(),style: TextStyle(color: color2,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5),) : Text(""),
            )
        ),
        Container(
          width: width / 2,
          height: width / 3,
          decoration: BoxDecoration(
              color: color6,

              border: Border(bottom: BorderSide(color: color2, width: 3),
                  top: BorderSide(color: color2, width: 3),
                  right: BorderSide(color: color2, width: 3))
          ),
          child: Center(
            child: b != 0 ? Text(b.toString(),style: TextStyle(color: color2,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),),
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
                border: Border(right: BorderSide(color: color6, width: 3),
                    bottom: BorderSide(color: color6, width: d == 3 ? 0 : 3))
            ),
            child: Center(
              child: a != 0 ? Text(a.toString(),style: TextStyle(color: color6,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),
            )
        ),
        Container(
          width: width / 3,
          height: width / 3,
          decoration: BoxDecoration(
              color: color5.withOpacity(0.7),
              border: Border(right: BorderSide(color: color6, width: 3),
                  bottom: BorderSide(color: color6, width: d == 3 ? 0 : 3))
          ),
          child: Center(
            child: b != 0 ? Text(b.toString(),style: TextStyle(color: color7,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),),
        ),
        Container(
          width: width / 3,
          height: width / 3,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: color6, width: d == 3 ? 0 : 3))
          ),
          child: Center(
            child: c != 0 ? Text(c.toString(),style: TextStyle(color: color6,fontFamily: 'CenturyGothic',fontSize: (width/3)*0.5)) : Text(""),),
        )
      ],
    );
  }

}