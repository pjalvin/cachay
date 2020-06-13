import 'package:cachay/User/Profile.dart';
import 'package:cachay/alerts/Alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AuthUser{
  Future<void> cerrarSesion(context)async{
    GoogleSignIn google=GoogleSignIn();
    await google.signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "/",ModalRoute.withName("/"));

  }
  Future<void> verinicio(context)async{

    FirebaseUser user=await FirebaseAuth.instance.currentUser();

    if(user!=null)
    {
      print("registrado");
      var snapshot=await Firestore.instance.collection('Usuarios').document(user.uid).get();

      if(snapshot.exists){

        var newProf=new Profile(user.email,snapshot['Nombre'],snapshot['oro'],snapshot['diamantes'],snapshot['cambioN'],snapshot['xp']);
        Navigator.pushNamedAndRemoveUntil(context, "/menu",ModalRoute.withName("/menu"),arguments: newProf);}
      else{
        FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
      String token= await _firebaseMessaging.getToken();
      DateTime date= new DateTime.now();
      var fecha=FieldValue.serverTimestamp();
        await showDialog(context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return Alerts().alertNuevoUsuario(context,user.uid,fecha,token,_firebaseMessaging,user.email);
            });}
    }
    else
    {
      print("no registrado");
      FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
      String token= await _firebaseMessaging.getToken();
      DateTime date= new DateTime.now();
      var fecha=FieldValue.serverTimestamp();
      var userAuth=AuthUser();
      int tip=await userAuth.SignInGoogle();
      FirebaseUser user=await FirebaseAuth.instance.currentUser();
      switch(tip){
        case 1:
          await Firestore.instance.collection('Usuarios').document(user.uid)
              .updateData({
            'token_noti':token
          });

          var snapshot=await Firestore.instance.collection('Usuarios').document(user.uid).get();
          var newProf=new Profile(user.email,snapshot['Nombre'],snapshot['oro'],snapshot['diamantes'],snapshot['cambioN'],snapshot['xp']);
          Navigator.pushNamedAndRemoveUntil(context, "/menu",ModalRoute.withName("/menu"),arguments: newProf);
          break;
        case 2:
          await showDialog(context: context,
              builder: (BuildContext context){
                return Alerts().alertNuevoUsuario(context,user.uid,fecha,token,_firebaseMessaging,user.email);
              });
          break;

        case 3:
          showDialog(context: context,
              builder: (BuildContext context){
                return Alerts().alertErrorInicio(context);
              });
          break;
      }

    }


  }
  Future<int> SignInGoogle() async{
    try{

      final FirebaseAuth _auth=FirebaseAuth.instance;
      final GoogleSignIn googleSignIn= new GoogleSignIn();
      GoogleSignInAccount acount=await googleSignIn.signIn();
      GoogleSignInAuthentication Gauth=await acount.authentication.catchError((e){print("Cancelado");});
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: Gauth.accessToken,
        idToken: Gauth.idToken,
      );
      await _auth.signInWithCredential(credential);
      FirebaseUser user= await FirebaseAuth.instance.currentUser();
      FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
      String token= await _firebaseMessaging.getToken();
      DateTime date= new DateTime.now();
      var fecha=FieldValue.serverTimestamp();
      var snapshot=await Firestore.instance.collection('Usuarios').document(user.uid).get();

      if(snapshot.exists)
        return 1;
      else
        return 2;
}
    catch(e){
      print(e);
      return 3;
    }

  }
}