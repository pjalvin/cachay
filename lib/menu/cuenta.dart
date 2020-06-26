//Pantalla de Cuenta registrada en el juego
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
import 'package:fluttertoast/fluttertoast.dart';
class Cuenta extends StatefulWidget {
  final Profile profile;
  @override
  _CuentaState createState() => _CuentaState(profile);
  Cuenta({
    Key key,
    @required this.profile,
  }) : super(key: key);
}
class _CuentaState extends State<Cuenta> {
  Size size;
  //Recursos de la pantalla cuenta
  Profile profile;
  _CuentaState(this.profile);
  int avatar=1;

  @override
  Widget build(BuildContext context) {
    //Aqui se obtiene el tamño de la pantalla
    setState(() {
      size=MediaQuery.of(context).size;
    });
    //Aqui se declara el tamño de la pantalla menos el tamaño del tabNavigation
    double heigthpage=size.height-50;
    return Container(
        color: Colors.white,
        width: size.width,
        height: size.height,
        child:ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Container(
                width: size.width,
                color: color2,
                height: heigthpage*0.7,
                child:Column(
                  children: <Widget>[
                    //WIdget para mostrar el avatar de la paersona
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
                    //Aqui se muestra el lugar del nombre,email, y la opcion para poder editar el mismo
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
                                  children: <Widget>[Text(profile.nombre,textAlign: TextAlign.right,style: TextStyle(color: color5,fontFamily: 'CenturyGothic',fontWeight: FontWeight.w300,fontSize: heigthpage*0.05),),
                                  ],
                                ) ),
                          Container(
                            height: heigthpage*0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: (){
                                    if(profile.cambNom==0){
                                      AlertCambiar(context, size.width, size.height);
                                    }
                                    else{
                                      Fluttertoast.showToast(msg: "Cambios maximos superados.",backgroundColor: color5.withOpacity(0.9),textColor: color7.withOpacity(0.8),gravity:ToastGravity.CENTER,
                                        toastLength: Toast.LENGTH_SHORT,);
                                    }
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
                        child: AutoSizeText(profile.email,textAlign: TextAlign.center,style: TextStyle(color: color6.withOpacity(0.3),fontFamily: 'CenturyGothic',fontSize: heigthpage*0.03),maxLines: 1,minFontSize:15,maxFontSize: 30,),
                      )
                    )
                  ],
                )
            ),
            //Lugar para poder cerrar sesion y la informacion de la palicacion
            Container(
                height: heigthpage*0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Boton cerrar sesion
                    Container(
                        height:heigthpage*0.20,
                      child:Center(
                        child: Container(
                          height: heigthpage*0.07,
                          width: size.width*0.4,
                          color:color3,
                          child: MaterialButton(
                            height: heigthpage*0.07,
                            child: Text('Cerrar Sesión',style: TextStyle(color: color6,fontFamily: 'CenturyGothic',fontSize: size.width*0.04),),
                            onPressed: (){
                              AuthUser().cerrarSesion(context);
                            },
                          ),
                        ),
                      )
                    ),
                    //Boton para la info de la aplicacion
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
                          onPressed: (){

                            Fluttertoast.showToast(msg: "\n        CACHAY        \n\n      Version 1.0\n\n@copyright 2020\n",backgroundColor: color6.withOpacity(0.95),textColor: color7.withOpacity(0.8),gravity:ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_LONG,);
                          },
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
  //Alert Dialog para poder cambiar el nombre de la cuenta
  AlertCambiar(context,width,height){
    showDialog(context: context,
    builder: (context){
      TextEditingController tcNombre=TextEditingController();
      final my_key=GlobalKey<FormState>();
      final my_key2=GlobalKey<FormFieldState>();
      bool enabled=true;
      Widget okButton = FlatButton(
        color: color2,
        child: Text("Aceptar",style: TextStyle(fontFamily: 'CenturyGothic',color: color6),),
        onPressed: () async{
          FocusScope.of(context).requestFocus(new FocusNode());
          enabled=false;
          if(my_key.currentState.validate()){
            try{
              var user=await FirebaseAuth.instance.currentUser();
              var userinfo=await Firestore.instance.collection("Usuarios").document(user.uid).get();
              if(userinfo.data["cambioN"]<1){
                userinfo.reference.updateData({
                  "Nombre":tcNombre.text,
                  "cambioN":1
                });
              }
              Navigator.pushNamedAndRemoveUntil(context, "/", ModalRoute.withName("/"));
            }
            catch(err){
              Navigator.pop(context);
            }
          }
        },
      );

      return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text('Ingrese su nombre',style: TextStyle(fontFamily: 'CenturyGothic'),),
          actions: <Widget>[
            okButton
          ],
          content: Form(
            key:my_key,
            child: TextFormField(
              key: my_key2,
              decoration: InputDecoration(enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: color2)),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color2)),fillColor: color2,focusColor:  color2,hoverColor : color2,border:UnderlineInputBorder(borderSide: BorderSide(color: color2))),
              controller: tcNombre,
              cursorColor: color3,
              maxLength: 10,
              readOnly: !enabled,
              maxLines: 1,
              validator: (val){
                if(val.length>=3){
                  return null;
                }
                else{
                  return "Error en el nombre";
                }
              },
            ),
          )
      );
    }
    );
  }

}
