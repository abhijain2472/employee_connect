import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/extension/date_extensions.dart';
import 'package:employee_connect/core/ui/app_assets.dart';
import 'package:employee_connect/core/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/sizing_util.dart';
import '../../../../core/ui/widgets/app_toggle_button.dart';
import '../../../../core/ui/widgets/horizontal_divider.dart';
import '../../../../core/ui/widgets/spacing.dart';
import 'bottom_cta_bar.dart';

class AppDatePicker extends StatefulWidget {
  final bool isFromEndDate;

  final DateTime? firstDay;
  final DateTime? selectedDay;

  const AppDatePicker({
    Key? key,
    this.isFromEndDate = false,
    this.firstDay,
    this.selectedDay,
  }) : super(key: key);

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  @override
  void initState() {
    selectedDate = widget.selectedDay ?? DateTime.now();
    super.initState();
  }

  DateTime? selectedDate;

  DateTime get firstDay => widget.firstDay ?? DateTime(2000);

  DateTime get todayDate => DateTime.now();

  DateTime get nextMonday => todayDate.nextMonday;

  DateTime get nextTuesday => todayDate.nextTuesday;

  DateTime get nextWeek => todayDate.nextWeek;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Space.vertical(Sp.px10),
            if (!widget.isFromEndDate) ...[
              Row(
                children: [
                  Expanded(
                    child: AppToggleButton(
                      key: const Key('today_button'),
                      isSelected: selectedDate.isSameDate(todayDate),
                      onTap: () {
                        setState(() {
                          selectedDate = todayDate;
                        });
                      },
                      title: AppStrings.today,
                    ),
                  ),
                  const Space.horizontal(Sp.px16),
                  Expanded(
                    child: AppToggleButton(
                      key: const Key('next_monday_button'),
                      isSelected: selectedDate.isSameDate(nextMonday),
                      onTap: () {
                        setState(() {
                          selectedDate = nextMonday;
                        });
                      },
                      title: AppStrings.nextMonday,
                    ),
                  ),
                ],
              ),
              const Space.vertical(Sp.px16),
              Row(
                children: [
                  Expanded(
                    child: AppToggleButton(
                      key: const Key('next_tuesday_button'),
                      isSelected: selectedDate.isSameDate(nextTuesday),
                      onTap: () {
                        setState(() {
                          selectedDate = nextTuesday;
                        });
                      },
                      title: AppStrings.nextTuesday,
                    ),
                  ),
                  const Space.horizontal(Sp.px16),
                  Expanded(
                    child: AppToggleButton(
                      key: const Key('after_1_week_button'),
                      isSelected: selectedDate.isSameDate(nextWeek),
                      onTap: () {
                        setState(() {
                          selectedDate = nextWeek;
                        });
                      },
                      title: AppStrings.after1Week,
                    ),
                  ),
                ],
              )
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: AppToggleButton(
                      isSelected: selectedDate == null,
                      onTap: () {
                        setState(() {
                          selectedDate = null;
                        });
                      },
                      title: AppStrings.noDate,
                    ),
                  ),
                  const Space.horizontal(Sp.px16),
                  Expanded(
                    child: AppToggleButton(
                      isSelected: selectedDate.isSameDate(todayDate),
                      onTap: () {
                        if (!todayDate.isAfter(firstDay)) {
                          context.showSnackBar(AppStrings.endDateError);
                          return;
                        }
                        setState(() {
                          selectedDate = todayDate;
                        });
                      },
                      title: AppStrings.today,
                    ),
                  ),
                ],
              ),
            ],
            TableCalendar(
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary),
                ),
                todayTextStyle: context.appTextStyle.bodyMedium!.copyWith(
                  color: AppColors.primary,
                ),
                defaultTextStyle: context.appTextStyle.bodyMedium!.copyWith(
                  color: AppColors.blackTextColor,
                ),
                selectedTextStyle: context.appTextStyle.bodyMedium!.copyWith(
                  color: AppColors.white,
                ),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: context.appTextStyle.titleMedium!.copyWith(
                  color: AppColors.blackTextColor,
                  fontSize: 18,
                ),
                headerMargin: const EdgeInsets.symmetric(vertical: Sp.px6),
                formatButtonVisible: false,
                leftChevronMargin: EdgeInsets.zero,
                rightChevronMargin: EdgeInsets.zero,
                titleCentered: true,
              ),
              selectedDayPredicate: (date) {
                return selectedDate.isSameDate(date);
              },
              onDaySelected: (date, _) {
                setState(() {
                  selectedDate = date;
                });
              },
              focusedDay: selectedDate ?? DateTime.now(),
              firstDay: firstDay,
              lastDay: todayDate.add(const Duration(days: 365)),
            ),
            const Space.vertical(Sp.px20),
            const HorizontalDivider(),
            const Space.vertical(Sp.px16),
            BottomCtaBar(
              padding: EdgeInsets.zero,
              onTapSave: () => context.pop(selectedDate),
              onTapCancel: () => context.pop(selectedDate),
              prefixWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SvgIcon(icon: AppAssets.calender),
                  const Space.horizontal(Sp.px6),
                  Text(
                    selectedDate != null ? selectedDate!.dMMMYYYY : 'No Date',
                    style: context.appTextStyle.bodyMedium?.copyWith(
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  DateTime? firstDate,
  DateTime? selectedDate,
  bool isFromEndDate = false,
}) async {
  return showDialog<DateTime?>(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRounding.px16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: Sp.px16),
      child: AppDatePicker(
        firstDay: firstDate,
        isFromEndDate: isFromEndDate,
        selectedDay: selectedDate,
      ),
    ),
  );
}
