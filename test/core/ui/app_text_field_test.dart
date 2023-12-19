import 'package:employee_connect/core/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('AppTextFieldWidget Test', () {
    late TextEditingController textController;
    late FocusNode focusNode;

    setUp(() {
      textController = TextEditingController(text: 'init');
      focusNode = FocusNode();
    });

    tearDown(() {
      textController.dispose();
      focusNode.dispose();
    });

    testWidgets('text field should render correctly with provided properties',
        (WidgetTester tester) async {
      String data = '';
      bool taped = false;
      await tester.pumpWidget(
        TestableWidget(
          child: AppTextFieldWidget(
            labelText: 'Label',
            hintText: 'Hint',
            textFieldController: textController,
            textStyle: const TextStyle(fontSize: 16),
            validator: (value) => value!.isEmpty ? 'Field is required' : null,
            isEnabled: true,
            readOnly: false,
            onChanged: (value) => data = value,
            onTap: () {
              taped = true;
            },
            onEditingComplete: () {},
            onFieldSubmitted: (value) {},
            onSaved: (value) {},
            maxLength: 50,
            maxLines: 3,
            minLines: 1,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            autoFocus: true,
            textCapitalization: TextCapitalization.words,
          ),
        ),
      );

      // Verify that the text field is rendered with the correct properties
      expect(find.text('Label'), findsOneWidget);
      expect(find.text('Hint'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      final textField =
          tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.validator!(''), 'Field is required');
      expect(textField.enabled, true);
      expect(textField.initialValue, 'init');

      // Validate onTap and onChanged callbacks
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      expect(tester.takeException(), isNull); // No exception should be thrown

      await tester.enterText(find.byType(TextFormField), 'Test');
      expect(tester.takeException(), isNull); // No exception should be thrown
      expect(taped, isTrue); //taped should be true
      expect(
          data,
          textController
              .text); // ensure that on changed callback works perfectly
    });

    testWidgets('should call onEditingComplete when editing is complete',
        (WidgetTester tester) async {
      var editingComplete = false;

      await tester.pumpWidget(
        TestableWidget(
          child: AppTextFieldWidget(
            labelText: 'Label',
            hintText: 'Hint',
            textFieldController: textController,
            onEditingComplete: () {
              editingComplete = true;
            },
          ),
        ),
      );

      // Enter some text and submit
      await tester.enterText(find.byType(TextFormField), 'Test');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Trigger a frame
      await tester.pump();

      // Verify that onEditingComplete is called when editing is complete
      expect(editingComplete, isTrue);
    });
  });
}
