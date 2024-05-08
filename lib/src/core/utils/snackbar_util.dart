import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/core/resources/resources.dart';

@sealed
class SnackBarUtil {
  SnackBarUtil._();

  static final GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();

  // static void showSnackBar({
  //   required BuildContext context,
  //   required String message,
  //   bool isError = false,
  // }) {
  //   ScaffoldMessenger.of(context)
  //     ..hideCurrentSnackBar()
  //     ..showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           message,
  //           style: const TextStyle(
  //             fontSize: 15,
  //             fontWeight: FontWeight.w400,
  //             color: Colors.white,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         backgroundColor: isError ? Colors.red : context.theme.mainColor,
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  // }

  // static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSuccessCustomSnackBar(
  //   BuildContext context,
  //   String message,
  // ) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       elevation: 6.0,
  //       behavior: SnackBarBehavior.floating,
  //       content: Text(
  //         message,
  //         textAlign: TextAlign.center,
  //       ),
  //       backgroundColor: Colors.greenAccent,
  //     ),
  //   );
  // }

  // static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildErrorCustomSnackBar(
  //   BuildContext context,
  //   String message,
  // ) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       elevation: 6.0,
  //       behavior: SnackBarBehavior.floating,
  //       content: Text(
  //         message,
  //         textAlign: TextAlign.center,
  //       ),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }

  // static ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason> buildTopBanner(
  //   BuildContext context,
  //   String message, {
  //   Color color = Colors.red,
  // }) {
  //   return ScaffoldMessenger.of(context).showMaterialBanner(
  //     MaterialBanner(
  //       content: Row(
  //         children: [
  //           Text(
  //             message,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(
  //               color: Colors.white,
  //             ),
  //           ),
  //         ],
  //       ),
  //       overflowAlignment: OverflowBarAlignment.start,
  //       // leading: const Icon(Icons.info),
  //       // padding: const EdgeInsets.only(right: 16, left: 16, top: 20),
  //       backgroundColor: color,
  //       actions: [
  //         TextButton(
  //           child: const Text(
  //             'Закрыть',
  //             style: TextStyle(
  //               color: Colors.white,
  //             ),
  //           ),
  //           onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static void showTopShortToast(
    BuildContext context, {
    required String message,
    double radius = 12,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(14),
    Color? color,
    Widget? body,
  }) {
    FToast().removeQueuedCustomToasts();

    // final FToast fToast = FToast();
    // fToast.init(context);

    final Widget toast = Container(
      padding: padding,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.black.withOpacity(0), width: 0.5),
        color: color ?? AppColors.static,
        boxShadow: const [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 24,
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 2,
          ),
        ],
      ),
      child: body ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
    );

    FToast().showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(milliseconds: 1500),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 50.0,
          left: 0,
          right: 0,
          // left: MediaQuery.of(context).size.width / 3,
          child: child,
        );
      },
    );
  }

  static void showErrorTopShortToast(
    BuildContext context,
    String message, {
    double radius = 12,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(14),
    Color? color,
    Widget? body,
  }) {
    FToast().removeQueuedCustomToasts();

    final Widget toast = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.black.withOpacity(0), width: 0.5),
          color: color ?? AppColors.static,
          boxShadow: const [
            BoxShadow(
              color: Color(0x28000000),
              blurRadius: 24,
            ),
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 2,
            ),
          ],
        ),
        child: body ??
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
      ),
    );

    FToast().showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(milliseconds: 1500),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 50.0,
          left: 0,
          right: 0,
          // left: MediaQuery.of(context).size.width / 3,
          child: child,
        );
      },
    );
  }
}
