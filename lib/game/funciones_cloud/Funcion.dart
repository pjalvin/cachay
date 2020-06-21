import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FuncionesJuegos{
  Future<List>randNum(num)async {
    CloudFunctions val=CloudFunctions.instance;
    final HttpsCallable callable =val.getHttpsCallable(
      functionName: 'randomGen',

    );
    dynamic a=await callable.call(<String, dynamic>{
      'tam': num,
    });
    return a.data['dados'];
  }
  Future<String>buscarPartida(int tipo)async {
    CloudFunctions val=CloudFunctions.instance;
    final HttpsCallable callable =val.getHttpsCallable(
      functionName: 'buscarPartida',
    );
    var id=await FirebaseAuth.instance.currentUser();
    var nombreSnap=await Firestore.instance.collection("Usuarios").document(id.uid).get();
    String nombre=nombreSnap.data["Nombre"];


    dynamic a=await callable.call(<String, dynamic>{
      'tipo':tipo,
      'uid':id.uid,
      'nombre':nombre
    });
    print(a.data['resp']);
    return a.data['resp'];
  }
  Future<List>subirPuntaje(List<int> num,tipo,sala)async {
    CloudFunctions val=CloudFunctions.instance;
    final HttpsCallable callable =val.getHttpsCallable(
      functionName: 'subirJugada',
    );
    var id=await FirebaseAuth.instance.currentUser();
    var nombreSnap=await Firestore.instance.collection("Usuarios").document(id.uid).get();
    String nombre=nombreSnap.data["Nombre"];
    print(id.uid);
    print(tipo);
    print(sala);
    print(nombre);
    print(num);
    dynamic a=await callable.call(<String, dynamic>{
      'uid':id.uid,
      'sala':sala,
      'jugada':num,
      'tipo':tipo,
      "nombre":nombre
    });
    print("algo");
    print(a.data['resp']);
    return [a.data['resp']];
  }
}