import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/features/auth/presentation/widgets/register_form.dart';
import 'package:youapp/common/widgets/gradient_button.dart';

class NoopToastHelper implements IToastHelper {
  @override
  void showError(BuildContext context, String message) {}
  @override
  void showSuccess(BuildContext context, String message) {}
}

void main() {
  testWidgets('RegisterForm renders and shows error on invalid fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: RegisterForm(toastHelper: NoopToastHelper()),
          ),
        ),
      ),
    );

    final registerButton = find.widgetWithText(GradientButton, 'Register');
    expect(registerButton, findsOneWidget);

    // Pastikan tombol disabled saat input kosong
    final GradientButton buttonWidget = tester.widget(registerButton);
    expect(buttonWidget.isEnabled, isFalse);

    await tester.tap(registerButton);
    await tester.pump();

    expect(find.text('Register'), findsWidgets); // judul dan tombol
  });

  testWidgets('Typing into fields updates their values', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: RegisterForm(toastHelper: NoopToastHelper()),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'testuser');
    await tester.enterText(find.byType(TextField).at(1), 'test@mail.com');
    await tester.enterText(find.byType(TextField).at(2), '12345678');
    await tester.enterText(find.byType(TextField).at(3), '12345678');

    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('test@mail.com'), findsOneWidget);
    expect(find.text('12345678'), findsNWidgets(2));

    // Setelah input terisi, tombol harus enabled
    await tester.pump();
    final registerButton = find.widgetWithText(GradientButton, 'Register');
    final GradientButton buttonWidget = tester.widget(registerButton);
    expect(buttonWidget.isEnabled, isTrue);
  });
}
