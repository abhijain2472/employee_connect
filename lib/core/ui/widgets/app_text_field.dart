import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../sizing_util.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.textFieldController,
    this.textStyle,
    this.validator,
    this.isEnabled = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.labelTextStyle,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon = '',
    this.suffixIcon = '',
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final TextEditingController? textFieldController;
  final TextStyle? textStyle;
  final FormFieldValidator<String>? validator;
  final bool isEnabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextStyle? labelTextStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autoFocus;
  final TextCapitalization textCapitalization;
  final String prefixIcon;
  final String suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sp.px16,
        vertical: Sp.px6,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.textFieldBorder,
        ),
        borderRadius: BorderRadius.circular(AppRounding.px4),
      ),
      child: Row(
        children: [
          if (prefixIcon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: Sp.px12),
              child: SvgPicture.asset(prefixIcon),
            ),
          Expanded(
            child: TextFormField(
              onTap: onTap,
              onChanged: onChanged,
              controller: textFieldController,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted: onFieldSubmitted,
              onSaved: onSaved,
              readOnly: readOnly,
              enabled: isEnabled,
              validator: validator,
              style: textStyle ??
                  context.appTextStyle.bodyLarge?.copyWith(
                    color: AppColors.blackTextColor,
                  ),
              minLines: minLines,
              maxLines: maxLines,
              maxLength: maxLength,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              autofocus: autoFocus,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: context.appTextStyle.bodyLarge?.copyWith(
                  color: AppColors.hintColor,
                ),
                isDense: true,
                floatingLabelBehavior: floatingLabelBehavior,
                hintText: hintText,
                labelText: labelText,
                labelStyle: labelTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffixIcon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: Sp.px12),
              child: SvgPicture.asset(suffixIcon),
            ),
        ],
      ),
    );
  }
}
