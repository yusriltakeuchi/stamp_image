library stamp_image;

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class StampImage {
  ///Create watermark to an existing image file [image] and custom Widget as the watermark item.
  ///You can customize the position using alignment
  static Future create(
      {required BuildContext context,
      required File image,
      required List<Widget> child,
      required Function(File) onSuccess}) async {
    OverlayState? overlayState = Overlay.of(context, rootOverlay: true);
    OverlayEntry? entry;
    await Future.delayed(Duration(milliseconds: 100));
    OverlayEntry? lastEntry = overlayState?.widget.initialEntries.first;
    entry = OverlayEntry(
      builder: (context) {
        return StampWidget(
          image: image,
          child: child,
          onSuccess: (file) {
            onSuccess(file);
          },
        );
      },
    );

    ///Set root overlay to top and watermark entry to below,
    ///we need this because we want to invisible the watermark entry
    overlayState?.insert(entry, above: lastEntry);
  }
}

class StampWidget extends StatefulWidget {
  final List<Widget> child;
  final File? image;
  final Function(File)? onSuccess;
  StampWidget({required this.child, required this.image, this.onSuccess});

  @override
  _StampWidgetState createState() => _StampWidgetState();
}

class _StampWidgetState extends State<StampWidget> {
  ///Global frame key
  final frameKey = GlobalKey();

  ///Set widget from RepaintBoundary into uint8List
  ///and convert into File
  Future showResult() async {
    await Future.delayed(Duration(milliseconds: 2000));
    Uint8List? currentFrame = await getUint8List(frameKey);

    Directory? dir = await getExternalStorageDirectory();
    String? path = dir?.path;
    final file = File('$path/stamp_image_${DateTime.now().toString()}.png');
    if (await file.exists()) {
      await file.delete();
    }
    file.create();
    file.writeAsBytesSync(currentFrame!);
    widget.onSuccess!(file);
  }

  ///Converting Widget to PNG
  Future<Uint8List?> getUint8List(GlobalKey widgetKey) async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 5.0);
    ByteData? byteData = await (image.toByteData(format: ImageByteFormat.png));
    return byteData?.buffer.asUint8List();
  }

  ///Generating list of child for watermark item
  List<Widget> generateWidget() => widget.child.map((e) => e).toList();

  @override
  void initState() {
    super.initState();
    this.showResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: frameKey,
        child: Stack(
          children: [
            Image.file(
              widget.image!,
              fit: BoxFit.cover,
            ),
            ...generateWidget()
          ],
        ),
      ),
    );
  }
}
