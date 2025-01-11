import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/governrate_model.dart';
import '../../../resourses/styles_manager.dart';
import '../widgets/governrate_card.dart';

class GovernrateTab extends StatelessWidget {
  const GovernrateTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<Governorate> governorates = getGovernorates();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        spacing: 16.0,
        children: [
          SizedBox(height: 20),
          Text(
            context.tr("taps.governorateTitle"),
            style: Styles.style18Medium(),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: governorates.length,
              itemBuilder: (context, index) {
                return GovernorateCard(governorate: governorates[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
