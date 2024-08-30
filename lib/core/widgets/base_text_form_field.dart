import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder, enabledBorder;
  final TextStyle? inputTextStyle, hintStyle;
  final bool isObsecureText;
  final bool enable;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? leading;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextAlign? textAlign;
  final int? maxLines;
  final Function? onTap;
  final bool readOnly;
  final Function(String)? onSubmit;

  const BaseTextFormField({
    super.key,
    this.contentPadding,
    this.backgroundColor,
    this.enabledBorder,
    this.borderColor,
    this.focusedBorder,
    this.keyboardType,
    this.hintStyle,
    this.enable = true,
    required this.hintText,
    this.inputTextStyle,
    this.isObsecureText = false,
    this.suffixIcon,
    this.leading,
    this.textAlign,
    this.controller,
     this.validator,
    this.maxLines,
    this.onTap,
    this.onSubmit,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => onTap?.call(),
      readOnly: readOnly,
      keyboardType: keyboardType,
      textAlign: textAlign ?? TextAlign.center,
      controller: controller,
      enabled: enable,
      validator: validator,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: borderColor ?? Colors.blue, width: 1.3),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: borderColor ?? Colors.blue, width: 1.3),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
        ),
        hintStyle: hintStyle ?? TextStyle(color: Colors.grey.shade300 , fontSize: 15),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: leading,
        fillColor: backgroundColor ?? Colors.blue,
        filled: backgroundColor != null ? true : false,
      ),
      obscureText: isObsecureText,
      style: inputTextStyle ?? const TextStyle(color: Colors.black , fontSize: 15),
      maxLines: maxLines,
      onFieldSubmitted: onSubmit,
    );
  }
}
