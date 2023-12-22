import 'package:employee_connect/core/ui/widget_keys.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/ui/sizing_util.dart';
import '../../../../core/ui/widgets/app_primary_button.dart';
import '../../../../core/ui/widgets/app_secondary_button.dart';
import '../../../../core/ui/widgets/spacing.dart';

class BottomCtaBar extends StatelessWidget {
  const BottomCtaBar({
    Key? key,
    required this.onTapSave,
    required this.onTapCancel,
    this.padding,
    this.prefixWidget,
    this.cancelKey,
    this.saveKey,
  }) : super(key: key);

  final VoidCallback onTapSave;
  final VoidCallback onTapCancel;
  final EdgeInsets? padding;
  final Widget? prefixWidget;
  final Key? cancelKey;
  final Key? saveKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: WidgetKeys.bottomCtaPadding,
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: Sp.px10,
            horizontal: Sp.px16,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (prefixWidget != null) prefixWidget!,
          const Spacer(),
          AppSecondaryButton(
            key: cancelKey,
            onTap: onTapCancel,
            title: AppStrings.cancelCTAText,
          ),
          const Space.horizontal(Sp.px16),
          AppPrimaryButton(
            // tapKey: const Key('date-save'),
            key: saveKey,
            onTap: onTapSave,
            title: AppStrings.saveCTAText,
          ),
        ],
      ),
    );
  }
}
