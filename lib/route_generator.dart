//Esta clase sirve para poder enrutar las diferentes pantallas de mi proyecto
//Aqui recibe el nombre y los argumentos que se envian en el navigator
//despues los redirige dependiendo del nombre

import 'package:cachay/InicioApp.dart';
import 'package:cachay/User/Profile.dart';
import 'package:cachay/game/espera.dart';
import 'package:cachay/game/mainGame.dart';
import 'package:cachay/main.dart';
import 'package:cachay/menu.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainCacho());
      case '/menu':
        if (args is Profile) {
          return MaterialPageRoute(
            builder: (_) => Menu(
              profile: args,
            ),
          );
        }
        else{
          return _errorRoute();
        }
        return _errorRoute();
      case '/mainGame':
        if(args is List){
          return MaterialPageRoute(
            builder: (context) => MainGame(
              args[0],args[1],args[2],args[3]
            ),);
          }
        break;
      case '/espera':
        if(args is List){
          return MaterialPageRoute(
            builder: (context) => Espera(
                args[0],args[1]
            ),);
        }
        break;

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}