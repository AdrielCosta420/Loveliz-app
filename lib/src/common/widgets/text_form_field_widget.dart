import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? initialValue;
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  const TextFormFieldWidget({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.maxLines,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.suffix,
    this.prefixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        initialValue: initialValue,
        maxLines: maxLines ?? 1,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        cursorHeight: 15,
        style: GoogleFonts.openSans(
          color: const Color(0xff33384B),
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,inputFormatters: inputFormatters,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(
            top: 12,
            bottom: 8,
            left: 16,
            right: 16,
          ),
          suffix: suffix,
          suffixStyle: const TextStyle(
            color: Color(0xff33384B),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(
            color: Color(0xffB2BCC9),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xffFAFAFC),
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffF04D00), width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffF04D00), width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB2BCC9), width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
          ),
          focusColor: const Color(0xffFAFAFC),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xFFA6767A)),
          ),
        ),
      ),
    );
  }
}
