import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../commons/all.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLine;
  final String? hintText;
  final TextAlign? textAlign;
  final double? fontSize;
  final int? maxLength;
  final double? borderRadius;
  final bool isTitle;
  final bool obscureText;
  final bool showCursor;
  final bool readOnly;
  final String? title;
  final TextInputType? textInputType;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    super.key,
    required this.controller,
    this.prefix,
    this.suffix,
    this.maxLine,
    this.hintText,
    this.textAlign,
    this.fontSize,
    this.maxLength,
    this.borderRadius,
    this.isTitle = false,
    this.title,
    this.onTap,
    this.obscureText = false,
    this.showCursor = true,
    this.inputFormatters, this.readOnly = false, this.onChanged, this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(isTitle)
          Text(
            title ?? "",
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: FontSize.s16,
              color: Colors.black38,
            ),
          ),
        if(isTitle)
          Gap(8),
        DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(borderRadius ?? 0)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller,
              maxLines: maxLine ?? 1,
              textAlign: textAlign ?? TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize ?? FontSize.s16,
                fontFamily: FontFamily.bold,
              ),
              maxLength: maxLength,
              textInputAction: TextInputAction.done,
              keyboardType: textInputType ?? TextInputType.text,
              obscureText: obscureText,
              inputFormatters: inputFormatters,
              readOnly: readOnly,
              showCursor: showCursor,
              onTap: onTap,
              onChanged: onChanged,
              textAlignVertical: suffix != null ? TextAlignVertical.center : null,
              decoration: InputDecoration(
                counter: SizedBox(),
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                suffixIcon: suffix,
                prefixIcon: prefix,
                hintText: hintText ?? "",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: FontSize.s16,
                  fontFamily: FontFamily.medium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // If backspace is pressed, remove the auto-added "/" characters
    if (newValue.selection.baseOffset < oldValue.selection.baseOffset) {
      return newValue;
    }

    // Add "/" after day (DD) and month (MM)
    if (text.length == 2 || text.length == 5) {
      if (!text.endsWith('/')) {
        text += '/';
      }
    }

    // Return the formatted text and set the correct cursor position
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
