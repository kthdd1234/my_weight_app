// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_weight_app/common/CommonModalButton.dart';
import 'package:my_weight_app/common/CommonModalSheet.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/widget/popup/AlertPopup.dart';
import 'package:permission_handler/permission_handler.dart';

ImagePicker picker = ImagePicker();

class ImageActionBottomSheet extends StatefulWidget {
  ImageActionBottomSheet({
    super.key,
    required this.onCamera,
    required this.onGallery,
  });

  Function(Uint8List) onCamera;
  Function(List<Uint8List>) onGallery;

  @override
  State<ImageActionBottomSheet> createState() => _ImageActionBottomSheetState();
}

class _ImageActionBottomSheetState extends State<ImageActionBottomSheet> {
  onCamera() async {
    try {
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      Uint8List? uint8List = await xFile?.readAsBytes();

      if (uint8List != null) widget.onCamera(uint8List);
    } catch (e) {
      PermissionStatus status = await Permission.camera.status;

      if (status.isDenied) {
        showDialog(
          context: context,
          builder: (context) => AlertPopup(
            desc: '카메라 접근 권한이 없습니다.\n설정으로 이동하여\n카메라 접근을 허용해주세요.',
            buttonText: '설정으로 이동',
            height: 195,
            onTap: openAppSettings,
          ),
        );
      }
    }
  }

  onGallery() async {
    List<XFile> pickedXFileList = await picker.pickMultiImage();
    List<Uint8List> pickedUint8ListList = [];

    for (var xFile in pickedXFileList) {
      Uint8List uint8List = await xFile.readAsBytes();
      pickedUint8ListList.add(uint8List);
    }

    widget.onGallery(pickedUint8ListList);
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '사진 추가',
      height: 195,
      child: Row(
        children: [
          CommonModalButton(
            svgName: 'camera',
            actionText: '카메라',
            onTap: onCamera,
          ),
          CommonSpace(width: 5),
          CommonModalButton(
            svgName: 'gallery',
            actionText: '갤러리',
            onTap: onGallery,
          )
        ],
      ),
    );
  }
}
