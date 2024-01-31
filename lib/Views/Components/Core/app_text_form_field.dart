import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/app_text.dart';
import 'package:flutter/material.dart';

class AppInputFormField extends StatelessWidget {
  final Function(String value)? onChange;
  final FormFieldValidator<String>? validator;
  String? label, hint;
  double borderRadius;
  bool goNextOnComplete, obscureText;
  String? prefixText, suffixText;
  Widget? prefixIcon, suffixIcon;
  TextEditingController? controller;
  TextInputType? textInputType;
  int minLines;
  int maxLines;
  bool? enabled = true;
  int? maxLength;
  Color textColor, cursorColor, enabledBorderColor, focusedBorderColor;
  Color? backgroundColor;
  bool showCounterText;
  Color? hintOrLabelColor;

  AppInputFormField({
    super.key,
    this.onChange,
    this.validator,
    this.label,
    this.hint,
    this.borderRadius = 8,
    this.prefixText,
    this.prefixIcon,
    this.suffixText,
    this.enabled,
    this.suffixIcon,
    this.controller,
    this.goNextOnComplete = false,
    this.textInputType,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    Color? textColor,
    Color? cursorColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    this.backgroundColor,
    this.hintOrLabelColor,
    this.showCounterText = true,
  })  : textColor = textColor ?? AppColors().textColor,
        cursorColor = cursorColor ?? AppColors().primaryColor,
        enabledBorderColor = enabledBorderColor ?? AppColors().grey300,
        focusedBorderColor = focusedBorderColor ?? AppColors().primaryColor.withOpacity(0.5);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: AppText(color: textColor).getStyle(),
      keyboardType: textInputType ?? TextInputType.text,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      controller: controller,
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      
      cursorColor: textColor,
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
      validator: validator,
      textInputAction: (maxLines > 1)
          ? TextInputAction.newline
          : (goNextOnComplete ? TextInputAction.next : TextInputAction.done),
      obscureText: obscureText,
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: hint,
        hintStyle: AppText(
          style: 'regular',
          color: hintOrLabelColor,
          size: 16,
        ).getStyle(),
        helperStyle: AppText(
          style: 'regular',
          color: AppColors().grey400,
          size: 10,
        ).getStyle(),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? AppColors().red
                : AppColors().primaryColor;
            return TextStyle(
              color: color,
            );
          },
        ),

        labelStyle: AppText(
          style: 'regular',
          color: hintOrLabelColor,
          size: 16,
        ).getStyle(),
        errorStyle: AppText(
          style: 'regular',
          color: AppColors().red,
          size: 12,
        ).getStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors().secondaryColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focusedBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: enabledBorderColor,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors().red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors().red,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors().grey200,
            width: 1,
          ),
        ),
        focusColor: focusedBorderColor,
        iconColor: MaterialStateColor.resolveWith((states) {
          final Color color = states.contains(MaterialState.focused)
              ? focusedBorderColor
              : enabledBorderColor;

          return color;
        }),
        prefixIconColor: MaterialStateColor.resolveWith((states) {
          final Color color = states.contains(MaterialState.focused)
              ? focusedBorderColor
              : enabledBorderColor;

          return color;
        }),
        suffixIconColor: MaterialStateColor.resolveWith((states) {
          final Color color = states.contains(MaterialState.focused)
              ? focusedBorderColor
              : enabledBorderColor;

          return color;
        }),
        fillColor: backgroundColor,
        filled: backgroundColor != null ? true : false,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        counterText: showCounterText ? null : "",
      ),
    );
  }
}
