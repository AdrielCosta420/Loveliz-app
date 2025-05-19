import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantitySaleBoxWidget extends StatefulWidget {
  final TextEditingController quantityController;
  const QuantitySaleBoxWidget({super.key, required this.quantityController});

  @override
  State<QuantitySaleBoxWidget> createState() => _QuantitySaleBoxWidgetState();
}

class _QuantitySaleBoxWidgetState extends State<QuantitySaleBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 65,
      child: TextFormField(
        controller: widget.quantityController,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        style: GoogleFonts.openSans(
          color: const Color(0xff33384B),
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(
            top: 14,
            bottom: 8,
            left: 8,
            right: 8,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFB2BCC9), width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xffF4F4F6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 1, color: Color(0xffD9D9D9)),
          ),
        ),

        onChanged: (value) {
          // validação opcional
          if (int.tryParse(value) == null) {
            // quantityController.text = '1';
          }
        },
      ),
    );
  }
}
