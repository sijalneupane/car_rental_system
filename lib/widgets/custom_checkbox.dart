import 'package:car_rental_system/core/util/color_utils.dart';
import 'package:car_rental_system/widgets/custom_sized_box.dart';
import 'package:car_rental_system/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomCheckbox extends StatelessWidget {
  bool? value;
  void Function(bool?)? onChanged;
  String data;
  CustomCheckbox(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value, onChanged: onChanged),
        CustomSizedBox(
          width: 0.005,
        ),
        Expanded(
          child: ReadMoreText(
            data, // Just a placeholder text to allow expansion
            trimLines: 2,
            colorClickableText: primaryColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'see more',
            trimExpandedText: 'see less',
            moreStyle:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor
            ),
            lessStyle:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
          ),
          ),
        ),
      ],
    );
  }
}
