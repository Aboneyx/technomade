import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:technomade/src/feature/main/presentation/widgets/create_station_bottom_sheet.dart';

@RoutePage()
class CreateRouteSecondPage extends StatefulWidget {
  const CreateRouteSecondPage({super.key});

  @override
  State<CreateRouteSecondPage> createState() => _CreateRouteSecondPageState();
}

class _CreateRouteSecondPageState extends State<CreateRouteSecondPage> {
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
          'Creating a route',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                hintText: 'Description',
                hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: AppColors.primaryColor300),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rate config',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
                    onPressed: () {
                      CreateStationBottomSheet.show(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => const NewStopCard(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 8),
              child: CustomButton(
                text: 'Create',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewStopCard extends StatelessWidget {
  const NewStopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.labelColorLightSecondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kaskelen',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 20,
                  constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
                  onPressed: () {},
                  icon: SvgPicture.asset(Assets.icons.deleteForeverOutline),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arrive time : 12:30'),
                    Text('Departure time: 23:00'),
                  ],
                ),
                Text(
                  '1750',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
