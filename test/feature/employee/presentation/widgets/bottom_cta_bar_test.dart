import 'package:employee_connect/core/ui/widget_keys.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/bottom_cta_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employee_connect/core/app_strings.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('BottomCtaBar should render correctly',
      (WidgetTester tester) async {
    bool onTapSaveCalled = false;
    bool onTapCancelCalled = false;

    await tester.pumpWidget(
      TestableWidget(
        child: BottomCtaBar(
          onTapSave: () {
            onTapSaveCalled = true;
          },
          onTapCancel: () {
            onTapCancelCalled = true;
          },
          padding: const EdgeInsets.all(20.0),
          prefixWidget: const Text('Prefix'),
        ),
      ),
    );

    // Verify that the BottomCtaBar is rendered
    expect(find.byType(BottomCtaBar), findsOneWidget);

    // Verify that the specified padding is applied
    expect(
        tester.widget<Padding>(find.byKey(WidgetKeys.bottomCtaPadding)).padding,
        const EdgeInsets.all(20.0));

    // Verify that the prefix widget is rendered
    expect(find.text('Prefix'), findsOneWidget);

    // Verify that the buttons are rendered with the correct text
    expect(find.text(AppStrings.cancelCTAText), findsOneWidget);
    expect(find.text(AppStrings.saveCTAText), findsOneWidget);

    // Tap on the Save button
    await tester.tap(find.text(AppStrings.saveCTAText));
    await tester.pump();

    // Verify that onTapSave callback is called
    expect(onTapSaveCalled, isTrue);

    // Tap on the Cancel button
    await tester.tap(find.text(AppStrings.cancelCTAText));
    await tester.pump();

    // Verify that onTapCancel callback is called
    expect(onTapCancelCalled, isTrue);
  });
}
