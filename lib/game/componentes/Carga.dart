import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';

class Carga extends StatelessWidget {
  final double width,height;

  Carga({
    Key key,
    @required this.width,
    @required this.height
  });
  @override
  Widget build(BuildContext context) {
      return Container(
        width: width,
        height: height,
        child: SpinKitPouringHourglass(
          color: color6.withOpacity(0.5),

          size: width*0.6,
        ),
      );

  }
}
