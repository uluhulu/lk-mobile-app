import 'package:flutter/material.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import 'claim_status_card_builder.dart';

class ClaimStatusCard extends StatelessWidget {
  final String status;
  const ClaimStatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _statusColor(context, status),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kBasePadding, vertical: kPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClaimStatusCardBuilder(status: status),
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context, String status) {
    switch (status) {
      case 'Отклонена':
        return MyTheme.of(context).orangeColor;
      case 'Удовлетворена':
        return MyTheme.of(context).successColor;
      default:
        return Colors.grey.shade500;
    }
  }
}
