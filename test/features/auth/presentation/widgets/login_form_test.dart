import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/features/auth/presentation/widgets/login_form.dart';
import 'package:youapp/common/widgets/gradient_button.dart';

class NoopToastHelper implements IToastHelper {
  @override
  void showError(BuildContext context, String message) {}
  @override
  void showSuccess(BuildContext context, String message) {}
}

void main() {
  testWidgets('LoginForm renders and shows error on empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: LoginForm(toastHelper: NoopToastHelper()),
          ),
        ),
      ),
    );

    final loginButton = find.widgetWithText(GradientButton, 'Login');
    expect(loginButton, findsOneWidget);

    // Pastikan tombol disabled saat input kosong
    final GradientButton buttonWidget = tester.widget(loginButton);
    expect(buttonWidget.isEnabled, isFalse);

    await tester.tap(loginButton);
    await tester.pump();
  });

  testWidgets('Typing into fields updates their values', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: LoginForm(toastHelper: NoopToastHelper()),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'testuser@mail.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');

    expect(find.text('testuser@mail.com'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);

    await tester.pump();
    final loginButton = find.widgetWithText(GradientButton, 'Login');
    final GradientButton buttonWidget = tester.widget(loginButton);
    expect(buttonWidget.isEnabled, isTrue);
  });
}
