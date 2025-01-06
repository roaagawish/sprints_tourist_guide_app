import 'package:flutter/material.dart';
import '../../../models/governrate_model.dart';
import '../../../resourses/styles_manager.dart';
import '../widgets/governrate_card.dart';

class GovernmentsTab extends StatelessWidget {
  const GovernmentsTab({super.key});

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
            'Most visited 3 Egyptian governorates.',
            style: Styles.style18Medium(),
          ),
          Expanded(
            flex: 8,
            child: ListView(
              children: List.generate(governorates.length, (index) {
                return GovernorateCard(governorate: governorates[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
