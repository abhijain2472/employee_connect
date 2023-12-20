import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/extension/app_extension.dart';
import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/extension/date_extensions.dart';
import 'package:employee_connect/core/ui/app_assets.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:employee_connect/core/ui/widgets/app_text_field.dart';
import 'package:employee_connect/core/ui/widgets/horizontal_divider.dart';
import 'package:employee_connect/core/ui/widgets/spacing.dart';
import 'package:employee_connect/core/ui/widgets/svg_icon.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/presentation/employee_role_enum.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/app_date_picker.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/bottom_cta_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({
    Key? key,
    this.employee,
  }) : super(key: key);

  final Employee? employee;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  late final TextEditingController nameTextController;
  late final TextEditingController roleTextController;
  late final TextEditingController startDateTextController;
  late final TextEditingController endDateTextController;
  late EmployeeRole selectedRole;
  late DateTime selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    roleTextController.dispose();
    startDateTextController.dispose();
    endDateTextController.dispose();
    super.dispose();
  }

  void _initializeData() {
    selectedRole = widget.employee?.employeeRole ?? EmployeeRole.none;
    selectedStartDate =
        widget.employee?.startDate.toDateTimeN ?? DateTime.now();
    selectedEndDate = widget.employee?.endDate.toDateTimeN;
    nameTextController = TextEditingController(text: widget.employee?.name);
    roleTextController = TextEditingController(text: selectedRole.label);
    startDateTextController =
        TextEditingController(text: selectedStartDate.toStartDateText);
    endDateTextController =
        TextEditingController(text: selectedEndDate?.dMMMYYYY ?? '');
  }

  bool get isUpdate => widget.employee != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate
              ? AppStrings.updateEmployeeAppBarTitle
              : AppStrings.addEmployeeAppBarTitle,
        ),
        actions: [
          if (isUpdate)
            IconButton(
              onPressed: () {
                context.readBloc<EmployeeBloc>().add(
                      DeleteEmployee(employee: widget.employee!),
                    );
                context.pop();
              },
              icon: const SvgIcon(icon: AppAssets.delete),
            ),
        ],
      ),
      body: Column(
        children: [
          const Space.vertical(Sp.px24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sp.px16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFieldWidget(
                  key: const Key(AppStrings.nameHintText),
                  hintText: AppStrings.nameHintText,
                  textFieldController: nameTextController,
                  prefixIcon: AppAssets.person,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _onTapRoleTextField(),
                ),
                const Space.vertical(Sp.px24),
                AppTextFieldWidget(
                  key: const Key(AppStrings.roleHintText),
                  hintText: AppStrings.roleHintText,
                  readOnly: true,
                  prefixIcon: AppAssets.work,
                  suffixIcon: AppAssets.dropDown,
                  textFieldController: roleTextController,
                  onTap: _onTapRoleTextField,
                ),
                const Space.vertical(Sp.px24),
                Row(
                  children: [
                    Expanded(
                      child: AppTextFieldWidget(
                        hintText: AppStrings.startDateHintText,
                        prefixIcon: AppAssets.calender,
                        textFieldController: startDateTextController,
                        readOnly: true,
                        onTap: _onTapStartDate,
                      ),
                    ),
                    const Space.horizontal(Sp.px16),
                    const SvgIcon(icon: AppAssets.rightArrow),
                    const Space.horizontal(Sp.px16),
                    Expanded(
                      child: AppTextFieldWidget(
                        hintText: AppStrings.endDateHintText,
                        prefixIcon: AppAssets.calender,
                        textFieldController: endDateTextController,
                        readOnly: true,
                        onTap: _onTapEndDate,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          const HorizontalDivider(),
          BottomCtaBar(
            onTapSave: _onTapSave,
            onTapCancel: context.pop,
          ),
        ],
      ),
    );
  }

  String get _validationErrorMsg {
    if (!nameTextController.text.isValid) {
      return AppStrings.nameValidationError;
    } else if (selectedRole == EmployeeRole.none) {
      return AppStrings.roleValidationError;
    }
    return '';
  }

  Employee get _employeePayload => Employee(
        employeeId: isUpdate
            ? widget.employee!.employeeId
            : DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameTextController.text,
        roleId: selectedRole.id,
        startDate: selectedStartDate.toString(),
        endDate: selectedEndDate?.toString() ?? '',
      );

  Future<void> _onTapSave() async {
    if (_validationErrorMsg.isNotEmpty) {
      context.showSnackBar(_validationErrorMsg);
      return;
    }
    final event = isUpdate
        ? UpdateEmployee(employee: _employeePayload)
        : AddEmployee(employee: _employeePayload);
    context.read<EmployeeBloc>().add(event);
    context.pop();
  }

  Future<void> _onTapRoleTextField() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppRounding.px16),
          topLeft: Radius.circular(AppRounding.px16),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return Container(
          color: AppColors.white,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              final role = EmployeeRole.forUi.elementAt(index);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  selectedRole = role;
                  roleTextController.text = role.label;
                  context.pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(Sp.px16),
                  child: Text(
                    role.label,
                    style: context.appTextStyle.bodyMedium?.copyWith(
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const HorizontalDivider(),
            itemCount: EmployeeRole.forUi.length,
          ),
        );
      },
    );
  }

  Future<void> _onTapStartDate() async {
    final date = await showAppDatePicker(
      context: context,
      selectedDate: selectedStartDate,
    );
    if (date != null) {
      selectedStartDate = date;
      selectedEndDate = null;
      startDateTextController.text = selectedStartDate.toStartDateText;
      endDateTextController.clear();
    }
  }

  Future<void> _onTapEndDate() async {
    final date = await showAppDatePicker(
      context: context,
      firstDate: selectedStartDate,
      selectedDate: selectedEndDate ?? selectedStartDate,
      isFromEndDate: true,
    );
    selectedEndDate = date;
    endDateTextController.text = selectedEndDate?.dMMMYYYY ?? "";
  }
}
