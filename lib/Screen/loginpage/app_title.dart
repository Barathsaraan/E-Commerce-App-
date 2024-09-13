import 'package:e_commerce/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTitle extends StatelessWidget {
  final String firstName;
  final String secondName;
  final Color firstColor;
  final Color secondColor;
  final double fontSize;

  const AppTitle({
    super.key,
    required this.firstName,
    required this.secondName,
    this.firstColor = Colors.white,
    this.secondColor = AppColors.commonColor,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$firstName ',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
