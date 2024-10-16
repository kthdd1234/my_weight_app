import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/widget/bottomSheet/ImageActionBottomSheet.dart';
import 'package:my_weight_app/widget/bottomSheet/ImageSelectionModalSheet.dart';
import 'package:my_weight_app/widget/view/ImageView.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class ImageContainer extends StatelessWidget {
  ImageContainer({
    super.key,
    required this.imageList,
    required this.onView,
    required this.onCamera,
    required this.onGallery,
    required this.onSlide,
    required this.onRemove,
  });

  List<Uint8List> imageList;
  Function() onView;
  Function(Uint8List uint8List) onCamera;
  Function(List<Uint8List>) onGallery;
  Function(Uint8List uint8List) onSlide, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isView = userRepository.user.categoryOpenIdList.contains(eImageId);

    onAddImage() {
      showModalBottomSheet(
        context: context,
        builder: (context) => ImageActionBottomSheet(
          onCamera: onCamera,
          onGallery: onGallery,
        ),
      );
    }

    onSelectionImage(Uint8List uint8List) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ImageSelectionModalSheet(
          uint8List: uint8List,
          onSlide: () => onSlide(uint8List),
          onRemove: () => onRemove(uint8List),
        ),
      );
    }

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '눈바디', isView: isView, onView: onView),
          isView
              ? Column(
                  children: [
                    ImageView(
                      uint8ListList: imageList,
                      onImage: onSelectionImage,
                    ),
                    CommonContainer(
                      isAddShadow: true,
                      outerPadding: EdgeInsets.only(
                        top: imageList.isEmpty ? 0 : 10,
                      ),
                      onTap: onAddImage,
                      height: 50,
                      child: Center(
                        child: CommonText(
                          text: '사진 추가',
                          color: grey.original,
                        ),
                      ),
                    )
                  ],
                )
              : const CommonNull(),
        ],
      ),
    );
  }
}
