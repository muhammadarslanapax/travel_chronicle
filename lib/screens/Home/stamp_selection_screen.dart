import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/provider/stapm_provider.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../utilities/app_colors.dart';

class StampSelectionScreen extends StatefulWidget {
  const StampSelectionScreen({super.key});

  @override
  State<StampSelectionScreen> createState() => _StampSelectionScreenState();
}

class _StampSelectionScreenState extends State<StampSelectionScreen> {
  @override
  void initState() {
    context.read<StampProvider>().getAllStamps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const AppBarWidget(
              text: "Select Stamp for Trip",
            ),
            Consumer<StampProvider>(
              builder: (context, provider, child) {
                if (provider.stampList.isEmpty) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }

                return Expanded(
                    child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.stampList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final model = provider.stampList[index];
                    return InkWell(
                      onTap: () {
                        context.read<StampProvider>().setSelectedStamp(model.stamp!);
                        context.read<StampProvider>().setselected(index);
                        Navigator.pop(
                          context,
                          addTripScreenRoute,
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: darkSkinColor,
                          border: Border.all(
                              width: 1, color: provider.getselected == index ? brownColor : Colors.transparent),
                          image: DecorationImage(
                            image: NetworkImage(model.stamp!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
