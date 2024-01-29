import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class ReUsableCard extends StatelessWidget {
  ReUsableCard({
    required this.jobType,
    this.bgColor,
    this.color,
    this.onTap,
    this.isTapped = false,
    super.key,
  });
  String jobType;
  Color? bgColor;
  Color? color;
  Function()? onTap;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return isTapped
        ? GestureDetector(
            onTap: onTap,
            child: Card(bgColor: bgColor, jobType: jobType, color: color),
          )
        : Card(bgColor: bgColor, jobType: jobType, color: color);
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.bgColor,
    required this.jobType,
    required this.color,
  });

  final Color? bgColor;
  final String jobType;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor ?? AppColor.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        jobType,
        style: GoogleFonts.inter(
          fontSize: 15,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
