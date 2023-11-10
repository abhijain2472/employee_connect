import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/ui/app_assets.dart';
import '../../../../core/ui/sizing_util.dart';
import '../../../../core/ui/widgets/spacing.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.emptyState),
          const Space.vertical(Sp.px4),
          Text(
            AppStrings.emptyStateText,
            style: context.appTextStyle.titleMedium?.copyWith(
              color: AppColors.blackTextColor,
            ),
          )
        ],
      ),
    );
  }
}
