import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/app/widgets/custom_fading_indicator.dart';

class CustomOverlayWidget extends StatelessWidget {
  const CustomOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: const Color.fromARGB(255, 239, 239, 239),
        ),
        child: const CustomFadingRingProgress(
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
