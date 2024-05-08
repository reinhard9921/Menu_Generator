import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  String networkUrl;
  CustomNetworkImage({Key? key, required this.networkUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.network(networkUrl,
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      return child;
    }, loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }));

    //   return Image.network(
    //     networkUrl,
    //     fit: BoxFit.fill,
    //     loadingBuilder: (BuildContext context, Widget child,
    //         ImageChunkEvent? loadingProgress) {
    //       if (loadingProgress == null) return child;
    //       return Center(
    //         child: CircularProgressIndicator(
    //           value: loadingProgress.expectedTotalBytes != null
    //               ? loadingProgress.cumulativeBytesLoaded /
    //                   loadingProgress.expectedTotalBytes!
    //               : null,
    //         ),
    //       );
    //     },
    //   );
  }
}
