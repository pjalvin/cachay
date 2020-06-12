import 'package:cachay/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  int exp=252;
  int puesto=234;
  List<List<String>> resultados=[
    ["Juan Perez","4506"],
    ["Luis Gonzales","4320"],
    ["Andres Flores","4108"],
    ["Ana Rosales","4005"],
    ["Juan Perez","3000"],
    ["Luis Gonzales","4320"],
    ["Andres Flores","4108"],
    ["Ana Rosales","4005"],
    ["Juan Perez","4506"],
    ["Luis Gonzales","4320"],
    ["Andres Flores","4108"],
    ["Ana Rosales","4005"]
  ];
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double heigthpage=size.height-50;
    return Container(
        color: Colors.white,
        child:Column(
          children: <Widget>[
            Container(
                width: size.width,
                color: color2,
                height: heigthpage*0.35,
                child:Column(
                  children: <Widget>[
                    Container(
                      height: heigthpage*0.35,
                      padding: EdgeInsets.all(heigthpage*0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: color5,

                            radius: heigthpage*0.11,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Puesto",style: TextStyle(color: color3,fontSize: heigthpage*0.03),),
                                  Text(puesto.toString(),style: TextStyle(color: color2,fontSize: heigthpage*0.07,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: heigthpage*0.01,
                            color: Colors.transparent,
                          ),
                          Container(
                            child:
                            Text(exp.toString()+" EXP",style: TextStyle(color: color6,fontSize: heigthpage*0.03),),
                          )
                        ],
                      )
                    ),
                  ],
                )
            ),

            Container(
                height: heigthpage*0.65,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child:Row(
                    children: <Widget>[
                          Container(
                              color:color1.withOpacity(0.8),
                              height: 40,
                              width: size.width*0.1,
                              child:Center(
                                child: Text(("N°").toString()),
                              )
                          ),
                          Container(
                              color:color1.withOpacity(0.8),
                              height: 40,
                              width: size.width*0.6,
                              child:Center(
                                child: Text(("Nombre").toString()),
                              ) ),
                          Container(
                              color:color1.withOpacity(0.8),
                              height: 40,
                              width: size.width*0.3,
                              child:Center(
                                child: Text(("XP").toString()) ,
                              ))
                  ],
                ),
                    ),
                    Container(
                      height: heigthpage*0.65-40,
                      color: color3,
                      child: datos(size.width, color3),
                    )
                  ],
                )
            )
          ],
        )
    );
  }
  Widget datos(width,color){
    return ListView(
      padding: EdgeInsets.all(0),
      children: resultados.asMap().entries.map((entries){
        return Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color:color,border: Border(right: BorderSide(color: color6))),
              height: 40,
              width: width*0.1,
              child:Center(
                  child:Text((entries.key+1).toString(),style: TextStyle(color: color6),)
              )
            ),
            Container(
                decoration: BoxDecoration(
                    color:color,border: Border(right: BorderSide(color: color6))),
                height: 40,
                width: width*0.6-1,
                child:Center(
                  child: Text((entries.value[0]).toString(),style: TextStyle(color: color6)),
                ) ),
            Container(
                color:color,
                height: 40,
                width: width*0.3-1,
                child:Center(
                  child: Text((entries.value[1]).toString(),style: TextStyle(color: color6)),
                ) )
          ],
        );
      }).toList(),
    );
  }
}
