import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../resources/color_asset/colors.dart';

class CircleProgerssIndicator extends StatefulWidget {
  const CircleProgerssIndicator({super.key});

  @override
  State<CircleProgerssIndicator> createState() => _CircleProgerssIndicatorState();
}

class _CircleProgerssIndicatorState extends State<CircleProgerssIndicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Container(
          width: 110, height: 110,
          decoration: BoxDecoration(
            color: CsColors.cs.accentColor.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Center(
            child: CupertinoActivityIndicator(
              radius: 20,
              color: Colors.white,
            )
          ),
        ),
      ),
    );
  }
}


// Widget GrayCircleIndicator = Container(
//   width: 110, height: 110,
//   decoration: BoxDecoration(
//     color: Colors.grey.withAlpha(100),
//     borderRadius: BorderRadius.all(Radius.circular(20))
//   ),
//   child: Center(
//     child: CircularProgressIndicator(
//       color: Colors.black,
//       backgroundColor: Colors.grey,
//     ),
//   ),
// );