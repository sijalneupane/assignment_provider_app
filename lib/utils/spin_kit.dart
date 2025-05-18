import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader {
  static backdropFilter(context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 3),
      child: Stack(
        children: [
          const Center(
            child: SpinKitFadingCircle(color: Color.fromARGB(255, 209, 5, 5),size: 75),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}