import 'package:cloud_functions/cloud_functions.dart';

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
}