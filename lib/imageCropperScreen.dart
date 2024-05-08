import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImageCropperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Cropper'),
      ),
      body: WebView(
        initialUrl: 'assets/cropper.html', // Path to your HTML file
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>{
          _createWebChannel(context),
        },
      ),
    );
  }

  JavascriptChannel _createWebChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'ImageCropper',
      onMessageReceived: (JavascriptMessage message) {
        // Handle message received from JavaScript
        // Example: message.message contains the cropped image data
        String croppedImageData = message.message;
        // Process the cropped image data
      },
    );
  }
}
