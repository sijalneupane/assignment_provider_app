// import 'package:car_rental_system/core/util/color_utils.dart';
// import 'package:flutter/material.dart';

// class LoadingAndErrorBuilder {
//   Widget Function(BuildContext, Widget, ImageChunkEvent?)? customLoadingBuilder(
//       {double? height, double? width}) {
//     return (context, child, loadingProgress) {
//       if (loadingProgress == null) {
//         return child;
//       }
//       return Container(
//         decoration:  BoxDecoration(color: Colors.grey[300]),
//         width: width ?? MediaQuery.of(context).size.width * 0.5,
//         height: height ?? MediaQuery.of(context).size.height * 0.2,
//         child: Center(
//             child: CircularProgressIndicator(
//           color: primaryColor,
//           value: loadingProgress.expectedTotalBytes != null
//               ? loadingProgress.cumulativeBytesLoaded /
//                   (loadingProgress.expectedTotalBytes ?? 1)
//               : null,
//         )),
//       );
//     };
//   }

//   Widget Function(BuildContext, Object, StackTrace?)? customErrorBuilder(
//       {double? height, double? width}) {
//     return (context, error, stackTrace) {
//       return Container(
//         width: width ?? MediaQuery.of(context).size.width * 0.5,
//         height: height ?? MediaQuery.of(context).size.height * 0.2,
//         color: Colors.grey[300],
//         child: const Icon(Icons.error),
//       );
//     };
//   }
// }
