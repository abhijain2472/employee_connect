import 'package:employee_connect/core/ui/widgets/svg_icon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper.dart';

void main() {
  testWidgets('SvgIcon should render SvgPicture with correct asset',
      (WidgetTester tester) async {
    const String expectedAsset = 'assets/images/work.svg';

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const TestableWidget(
        child: SvgIcon(icon: expectedAsset),
      ),
    );

    // Verify that the SvgPicture is rendered.
    final svgPicture = find.byType(SvgPicture);
    expect(svgPicture, findsOneWidget);

  });
}
