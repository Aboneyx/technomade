import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:technomade/src/feature/main/presentation/vmodel/create_route_vmodel.dart';
import 'package:technomade/src/feature/main/presentation/widgets/add_stop_bottom_sheet.dart';
import 'package:technomade/src/feature/main/presentation/widgets/stop_card.dart';

@RoutePage()
class CreateRouteSecondPage extends StatefulWidget implements AutoRouteWrapper {
  final CreateRouteVmodel createRouteVmodel;
  const CreateRouteSecondPage({
    super.key,
    required this.createRouteVmodel,
  });

  @override
  State<CreateRouteSecondPage> createState() => _CreateRouteSecondPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider.value(value: createRouteVmodel),
      ],
      child: this,
    );
  }
}

class _CreateRouteSecondPageState extends State<CreateRouteSecondPage> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = Provider.of<CreateRouteVmodel>(context, listen: false).description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateRouteVmodel>(
      builder: (context, v, c) {
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
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverList.list(
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextField(
                        hintText: 'Description',
                        controller: descriptionController,
                        hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppColors.primaryColor300),
                        ),
                        maxLines: 3,
                        onChanged: (p0) {
                          v.description = p0;
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Route config',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
                            onPressed: () {
                              AddStopBottomSheet.show(
                                context,
                                createRouteVmodel: Provider.of<CreateRouteVmodel>(context, listen: false),
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) => StopCard(
                      onDeleteTap: () {
                        v.removeStops(v.stops[index]);
                      },
                      stopsPayload: v.stops[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: v.stops.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 8),
            child: CustomElevatedButton(
              text: 'Create',
              onPressed: v.stops.length > 1 && v.description != null && v.description!.isNotEmpty ? () {} : null,
              style: CustomElevatedButtonStyles.primaryButtonStyle(context),
              child: null,
            ),
          ),
        );
      },
    );
  }
}
