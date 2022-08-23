import 'dart:io';

import 'package:coupled/Utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhoto extends StatefulWidget {
  final dynamic img;

  const ViewPhoto({Key? key, this.img}) : super(key: key);

  @override
  _ViewPhotoState createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  var image;

  @override
  void initState() {
    if (widget.img is File) {
      image = FileImage(widget.img);
    } else {
      image = NetworkImage(widget.img);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: PhotoView(
              filterQuality: FilterQuality.high,
              imageProvider: image,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: EdgeInsets.only(
                  top: 25,
                  left: 1,
                ),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: CoupledTheme().primaryPink,
                    ))),
          ),
        ],
      ),
    );
  }
}
