import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Movimientos{
  Future<bool> SubirMovi(idSala,jugada1,jugada2) async {

    try{
      var id=await FirebaseAuth.instance.currentUser();
      await Firestore.instance.collection("Salas").document(idSala).collection("jugadores").document(id.uid).updateData({
        "jugada1":jugada1,
        "jugada2":jugada2
      });
      return true;
    }
    catch(err){
      print(err);
      return false;
    }
  }
}