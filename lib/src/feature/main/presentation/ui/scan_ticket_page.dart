import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/presentation/widgets/qr_scanner_overlay_shape.dart';

const _tag = 'ScanTicketPage';

@RoutePage()
class ScanTicketPage extends StatefulWidget {
  const ScanTicketPage({super.key});

  @override
  State<ScanTicketPage> createState() => _ScanTicketPageState();
}

class _ScanTicketPageState extends State<ScanTicketPage> {
  final MobileScannerController controller = MobileScannerController();
  Barcode? barcode;
  PersistentBottomSheetController? bottomSheetController;
  // BarcodeCapture? capture;

  Future<void> onDetect(BarcodeCapture barcodeCapture) async {
    // capture = barcode;

    if (!mounted) return;

    if (kDebugMode) {
      log('${barcodeCapture.barcodes.length}', name: _tag);
      log('${barcodeCapture.barcodes.firstOrNull?.displayValue}', name: _tag);
      log('${barcode?.displayValue}', name: _tag);
    }

    if (barcode?.displayValue != barcodeCapture.barcodes.firstOrNull?.displayValue) {
      log('this.barcode?.displayValue - ${barcode?.displayValue}', name: _tag);
      log(
        'barcode.barcodes.first.displayValue - ${barcodeCapture.barcodes.first.displayValue}',
        name: _tag,
      );

      setState(() => barcode = barcodeCapture.barcodes.first);

      if (barcode?.displayValue != null) {
        // BlocProvider.of<QrCardScannerCubit>(context).getUserByQr(
        //   qr: barcode!.displayValue!,
        // );
      }
    }
  }

  MobileScannerArguments? arguments;

  @override
  void initState() {
    // controller.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      // center: MediaQuery.sizeOf(context).center(Offset(0, -100)),
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 320,
      height: 320,
    );

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 24,
            constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
            onPressed: () {
              context.router.maybePop();
            },
            icon: SvgPicture.asset(Assets.icons.arrowLeftDropCircleOutline),
          ),
        ),
        leadingWidth: 48,
        title: const Text(
          'Check tickets',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            MobileScanner(
              // fit: BoxFit.cover,
              scanWindow: scanWindow,
              controller: controller,
              onScannerStarted: (arguments) {
                setState(() {
                  this.arguments = arguments;
                });
              },
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: onDetect,
            ),
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: AppColors.mainColor,
                    borderRadius: 1,
                    borderLength: 56,
                    borderWidth: 5,
                    cutOutSize: 320,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: MediaQuery.of(context).viewInsets .bottom + 16,
            //   right: 65,
            //   left: 65,
            //   child: CustomButton(
            //     onPressed: () {
            //       context.router.pop();
            //     },
            //     style: CustomButtonStyles.primaryButtonStyle(context),
            //     text: context.localized.myQRcode,
            //     child: null,
            //   ),
            // ),
            if (kDebugMode)
              Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    children: [
                      Text(
                        barcode?.displayValue ?? 'Scan something!',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
