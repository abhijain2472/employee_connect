import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/empty_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Empty State view widget test',
    () {
      testWidgets(
        'EmptyStateView test',
        (widgetTester) async {
          late BuildContext context;
          await widgetTester.pumpWidget(
            MaterialApp(
              home: Builder(builder: (c) {
                context = c;
                return EmptyStateView();
              }),
            ),
          );
          await widgetTester.pump();
          expect(find.byType(Center), findsOneWidget);
          expect(
            find.byWidgetPredicate((widget) =>
                widget is Column &&
                widget.mainAxisAlignment == MainAxisAlignment.center),
            findsOneWidget,
          );
          expect(find.text(AppStrings.emptyStateText), findsOneWidget);
          expect(
              find.byWidgetPredicate(
                (widget) =>
                    widget is Text &&
                    widget.data == AppStrings.emptyStateText &&
                    widget.style ==
                        context.appTextStyle.titleMedium?.copyWith(
                          color: AppColors.blackTextColor,
                        ),
              ),
              findsOneWidget);
        },
      );
    },
  );
}
