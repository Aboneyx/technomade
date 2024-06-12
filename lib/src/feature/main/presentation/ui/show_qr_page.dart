import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/model/ticket_dto.dart';

@RoutePage()
class ShowQrPage extends StatefulWidget {
  final TicketDTO ticket;
  const ShowQrPage({super.key, required this.ticket});

  @override
  State<ShowQrPage> createState() => _ShowQrPageState();
}

class _ShowQrPageState extends State<ShowQrPage> {
  @override
  Widget build(BuildContext context) {
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
          'Back',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              QrImageView(
                data: '${widget.ticket.uuid}',
                size: 250.0,
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ticket Confirmation',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.mainColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Please, show this code to the driver !',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
