import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T? value;
  final String? labelText;
  final String? hintText;

  const DropdownButtonFormFieldWidget({
    super.key,
    required this.items,
    this.onChanged,
    this.value,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: DropdownButtonFormField<T>(
        value: value,
        style: GoogleFonts.openSans(
          color: const Color(0xff33384B),
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        items: items,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(
            top: 12,
            bottom: 8,
            left: 16,
            right: 16,
          ),
          filled: true,
          fillColor: const Color(0xffFAFAFC),
          labelText: labelText ?? 'Selecione',
          hintText: hintText ?? 'Selecione uma opção',
          hintStyle: const TextStyle(
            color: Color(0xffB2BCC9),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
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
