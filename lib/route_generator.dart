import 'package:cachay/User/Profile.dart';
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
          return MaterialPageRoute(
            builder: (context) => MainGame(
            ),
          );
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