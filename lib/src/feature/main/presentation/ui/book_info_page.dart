import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';

@RoutePage()
class BookInfoPage extends StatefulWidget {
  const BookInfoPage({super.key});

  @override
  State<BookInfoPage> createState() => _BookInfoPageState();
}

class _BookInfoPageState extends State<BookInfoPage> {
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
      body: const SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Almaty ----- Turkestan',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  BookInfoRow(
                    firstTitle: 'Date & Time',
                    firstSubtitle: '12 march, 8:30',
                    secondTitle: 'Arrival',
                    secondSubtitle: '12 march, 15:30',
                  ),
                  BookInfoRow(
                    firstTitle: 'Ticket',
                    firstSubtitle: '3 seats',
                    secondTitle: 'Seat number',
                    secondSubtitle: '15, 18, 27',
                  ),
                  BookInfoRow(
                    firstTitle: 'Price',
                    firstSubtitle: '30 000 ₸',
                    secondTitle: 'Bus number',
                    secondSubtitle: '122040',
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '30 000 ₸',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: 36,
                text: 'Book',
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookInfoRow extends StatelessWidget {
  final String firstTitle;
  final String firstSubtitle;

  final String secondTitle;
  final String secondSubtitle;

  const BookInfoRow({
    super.key,
    required this.firstTitle,
    required this.firstSubtitle,
    required this.secondTitle,
    required this.secondSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                firstSubtitle,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                secondTitle,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                secondSubtitle,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
