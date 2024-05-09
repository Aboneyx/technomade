import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';

class CustomLoadingWidget extends StatelessWidget {
  final bool isError;
  final double size;
  final double? value;

  const CustomLoadingWidget({
    super.key,
    this.isError = false,
    this.size = 100,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Lottie.asset('assets/lotties/loading.json'),
      child: SizedBox(
        // height: size,
        // width: size,
        child: RepaintBoundary(
          child: CircularProgressIndicator.adaptive(
            value: value,
            backgroundColor: isError ? Colors.red : AppColors.mainColor, //  null,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.static, //<-- SEE HERE
            ),
          ),
        ),
      ),
    );
  }
}
