import 'package:cachay/main.dart';
import 'package:flame/widgets/animation_widget.dart';
import 'package:flutter/material.dart';
class Dados{
  Widget dadoGira(width, height,tipo,_animation,_animationVolteo) {
    return Center(
      child: Container(
          width: width,
          height: height,
          child: tipo==1
              ?AnimationWidget(animation: _animation,)
              :AnimationWidget(animation: _animationVolteo,)
      ),
    );
  }

}