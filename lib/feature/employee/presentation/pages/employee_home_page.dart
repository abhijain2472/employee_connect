import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:employee_connect/feature/employee/presentation/pages/add_employee_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_bloc.dart';
import '../widgets/employee_list_view.dart';
import '../widgets/empty_state_view.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homePageAppBarTitle),
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeError) {
            context.showSnackBar(state.error);
          } else if (state is EmployeeLoaded &&
              state.type == EmployeeLoadedType.delete) {
            context.showSnackBar(
              AppStrings.deleteEmployeeMsg,
              ctaText: AppStrings.undo,
              onTap: () => context.readBloc<EmployeeBloc>().add(
                    UndoDeleteEmployee(),
                  ),
            );
          }
        },
        builder: (BuildContext context, state) {
          if (state is EmployeeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmployeeLoaded) {
            if (!state.hasData) {
              return const EmptyStateView();
            }
            return ListView(
              children: [
                if (state.hasCurrentEmployee)
                  EmployeeListWithLabel(
                    employees: state.currentEmployees,
                    label: AppStrings.currentEmployeesLabel,
                  ),
                if (state.hasPreviousEmployee)
                  EmployeeListWithLabel(
                    employees: state.previousEmployees,
                    label: AppStrings.previousEmployeesLabel,
                  ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRounding.px8),
        ),
        onPressed: () => context.push(const AddEmployeePage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
