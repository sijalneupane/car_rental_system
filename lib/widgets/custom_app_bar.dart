import 'package:car_rental_system/core/util/string_utils.dart';
import 'package:car_rental_system/widgets/custom_back_page_icon.dart';
import 'package:car_rental_system/widgets/custom_no_border_icon_button.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  // String pageTitle;
  bool? hasBackButton;
  Widget? middleChild;
  IconData? additionalIcon;
  AlignmentGeometry? alignmentOfMiddleChild;
  CustomAppBar(
      {super.key, this.hasBackButton, this.middleChild, this.additionalIcon,this.alignmentOfMiddleChild});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Stack(
        children: [
          widget.hasBackButton ?? false
              ? Positioned(left: 0,child: CustomBackPageIcon())
              : const SizedBox(),
          Padding(
            padding:widget.alignmentOfMiddleChild==Alignment.centerLeft ? const EdgeInsets.only(left:50.0): const EdgeInsets.only(left: 0.0),
            child: Align(
              alignment:widget.alignmentOfMiddleChild ?? Alignment.center,
              child: widget.middleChild),
          ),
          widget.additionalIcon != null
              ? Positioned(
                  right: 0,
                  child: CustomNoBorderIconButton(
                      onPressed: () {}, icon: widget.additionalIcon))
              : const SizedBox()
        ],
      ),
    );
  }
}
