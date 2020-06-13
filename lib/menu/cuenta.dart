import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cachay/User/Auth.dart';
import 'package:cachay/User/Profile.dart';
import 'package:cachay/alerts/Alerts.dart';
import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class Cuenta extends StatefulWidget {
  final Profile profile;
  @override
  _CuentaState createState() => _CuentaState();
  Cuenta({
    Key key,
    @required this.profile,
  }) : super(key: key);
}

class _CuentaState extends State<Cuenta> {
  int avatar=1;

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
                height: heigthpage*0.7,
                child:Column(
                  children: <Widget>[
                    Container(
                        height: heigthpage*0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[ Container(
                            height: heigthpage*0.25,
                            width: heigthpage*0.25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(heigthpage*0.3),border: Border.all(color: color6,width: 3)),
                            child: Icon(
                                Icons.person,size: heigthpage*0.2,color: color5,
                            ),
                          )]
                        )
                    ),
                    Container(
                      width: size.width,
                        height: heigthpage*0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                              Container(
                                height:heigthpage*0.08,
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[Text(widget.profile.nombre,textAlign: TextAlign.right,style: TextStyle(color: color5,fontFamily: 'CenturyGothic',fontWeight: FontWeight.w300,fontSize: heigthpage*0.05),),
                                  ],
                                ) ),
                          Container(
                            height: heigthpage*0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: (){
                                  },
                                  child: Text("editar",textAlign: TextAlign.right,style: TextStyle(color: color6,fontStyle: FontStyle.italic,fontFamily: 'CenturyGothic',fontWeight: FontWeight.w300,fontSize: heigthpage*0.025)
                                ))
                                ],
                            )
                          )
                        ],
                      )),
                    Container(
                      padding: EdgeInsets.all(3),
                        width: size.width,
                        height: heigthpage*0.07,
                      child: Center(
                        child: AutoSizeText(widget.profile.email,textAlign: TextAlign.center,style: TextStyle(color: color6.withOpacity(0.3),fontFamily: 'CenturyGothic',fontSize: heigthpage*0.03),maxLines: 1,minFontSize:15,maxFontSize: 30,),
                      )
                    )
                  ],
                )
            ),
            Container(
                height: heigthpage*0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height:heigthpage*0.20,
                      child:Center(
                        child: Container(
                          height: heigthpage*0.07,
                          width: size.width*0.4,
                          color:color3,
                          child: MaterialButton(
                            height: heigthpage*0.07,
                            child: Text('Cerrar Sesión',style: TextStyle(color: color6,fontFamily: 'CenturyGothic',fontSize: size.width*0.05),),
                            onPressed: (){
                              AuthUser().cerrarSesion(context);
                            },
                          ),
                        ),
                      )
                    ),
                    Container(
                      height:heigthpage*0.1,
                      padding: EdgeInsets.all(heigthpage*0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          Container(
                          width:heigthpage*0.05,
                          height: heigthpage*0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(heigthpage*0.05))),
                          child:MaterialButton(
                            padding: EdgeInsets.all(0),
                          onPressed: (){},
                        child: Icon(Icons.info_outline,size: heigthpage*0.05,color: color2,)
                        ))

                        ],
                      ),
                    )
                  ],
                )
            )
          ],
        )
    );
  }


}
