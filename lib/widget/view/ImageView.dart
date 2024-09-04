import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonImage.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';

class ImageView extends StatefulWidget {
  ImageView({
    super.key,
    required this.uint8ListList,
    required this.onImage,
  });

  List<Uint8List> uint8ListList;
  Function(Uint8List) onImage;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  image(Uint8List uint8List, double height) {
    return Expanded(
      child: CommonImage(
        uint8List: uint8List,
        height: height,
        onTap: widget.onImage,
      ),
    );
  }

  imageList() {
    List<Uint8List> uint8ListList = widget.uint8ListList;

    switch (uint8ListList.length) {
      case 1:
        return CommonImage(
          uint8List: uint8ListList[0],
          height: 250,
          onTap: widget.onImage,
        );

      case 2:
        return Row(children: [
          image(uint8ListList[0], 150),
          CommonSpace(width: 5),
          image(uint8ListList[1], 150)
        ]);
      case 3:
        return Row(
          children: [
            image(uint8ListList[0], 100),
            CommonSpace(width: 5),
            image(uint8ListList[1], 100),
            CommonSpace(width: 5),
            image(uint8ListList[2], 100)
          ],
        );
      case 4:
        return Column(
          children: [
            Row(
              children: [
                image(uint8ListList[0], 100),
                CommonSpace(width: 5),
                image(uint8ListList[1], 100),
                CommonSpace(width: 5),
                image(uint8ListList[2], 100)
              ],
            ),
            CommonSpace(height: 5),
            CommonImage(
              uint8List: uint8ListList[3],
              height: 250,
              onTap: widget.onImage,
            )
          ],
        );

      case 5:
        return Column(
          children: [
            Row(
              children: [
                image(uint8ListList[0], 100),
                CommonSpace(width: 5),
                image(uint8ListList[1], 100),
                CommonSpace(width: 5),
                image(uint8ListList[2], 100)
              ],
            ),
            CommonSpace(height: 5),
            Row(children: [
              image(uint8ListList[3], 150),
              CommonSpace(width: 5),
              image(uint8ListList[4], 150)
            ])
          ],
        );

      case 6:
        return Column(
          children: [
            Row(
              children: [
                image(uint8ListList[0], 100),
                CommonSpace(width: 5),
                image(uint8ListList[1], 100),
                CommonSpace(width: 5),
                image(uint8ListList[2], 100)
              ],
            ),
            CommonSpace(height: 5),
            Row(children: [
              image(uint8ListList[3], 100),
              CommonSpace(width: 5),
              image(uint8ListList[4], 100),
              CommonSpace(width: 5),
              image(uint8ListList[5], 100)
            ])
          ],
        );
      default:
        return const CommonNull();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.uint8ListList.isNotEmpty ? imageList() : const CommonNull();
  }
}
