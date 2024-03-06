import 'package:driver/constants/colors.dart';
import 'package:driver/constants/font.dart';
import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function()? onTap;

  const DateInputField({
    required this.controller,
    required this.hintText,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            decoration: InputDecoration(
              counterText: '',
              fillColor: kWhiteColor,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
              hintText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: const TextStyle(
                fontSize: textMedium,
                fontWeight: FontWeight.w400,
                // color: hintColor,
              ),
              // prefixIcon: prefixIcon,
              suffixIcon: const Icon(
                Icons.calendar_today_rounded,
                color: COLOR_PLACE_HOLDER,
              ),
              errorStyle: const TextStyle(
                fontSize: textMedium,
                fontWeight: FontWeight.normal,
                color: kRed,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 1, color: kOrange),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                // borderSide: BorderSide(width: 0, color: COLOR_TEXT_MAIN),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 0, color: kGrey1),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 0, color: kGrey1)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 1, color: kRed)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 1, color: kGrey1)),
              focusColor: kWhiteColor,
              hoverColor: kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
