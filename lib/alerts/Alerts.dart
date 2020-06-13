import 'package:cachay/User/Profile.dart';
import 'package:cachay/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alerts{
  Widget alertErrorInicio(context){
    Widget okButton = FlatButton(
      child: Text("Aceptar",style: TextStyle(fontFamily: 'CenturyGothic',color: color2),),
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        Navigator.pushNamedAndRemoveUntil(context, "/",ModalRoute.withName("/"));
      },
    );
    return AlertDialog(
        title: Text('No se pudo Iniciar Sesion',style: TextStyle(fontFamily: 'CenturyGothic')),
        actions: <Widget>[
          okButton
        ]);
  }
  Widget alertNuevoUsuario(context,userid,fecha,token,firebaseM,correo) {
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

          await Firestore.instance.collection('Usuarios').document(userid)
              .setData({
            'Fecha de Registro':fecha,
            'Nombre': tcNombre.text,
            'token_noti':token,
            'cambioN':0,
            'oro': 0,
            'diamantes':0,
            'xp':0,
          });
          firebaseM.subscribeToTopic("enablenoti");
          var sha=await SharedPreferences.getInstance();
          sha.setBool("notificaciones", true);

          var newProf=new Profile(correo,tcNombre.text,0,0,0,0);
          Navigator.pushNamedAndRemoveUntil(context, "/menu",ModalRoute.withName("/"),arguments: newProf);
        }
      },
    );
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: AlertDialog(
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
                if(val!=""){
                  return null;
                }
                else{
                  return "Ingrese un nombre";
                }
              },
            ),
          )
      ),
    );
  }
}