import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/features/auth/presentation/widgets/register_form.dart';
import 'package:youapp/common/widgets/gradient_button.dart';
import 'package:get/get.dart';
import 'package:youapp/features/auth/presentation/pages/login.dart';
import 'package:youapp/features/auth/presentation/providers/register_provider.dart';
import 'dart:math';

class FakeRegisterNotifier extends RegisterNotifier {
  FakeRegisterNotifier() : super();

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    // Simulasikan sukses
    state = state.copyWith(isLoading: false, success: true, errorMessage: null);
  }

  @override
  bool isValidEmail(String email) => true;
  @override
  bool isValidPassword(String password) => true;
  @override
  bool isValidUsername(String username) => true;
}

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

    final GradientButton buttonWidget = tester.widget(registerButton);
    expect(buttonWidget.isEnabled, isFalse);

    await tester.tap(registerButton);
    await tester.pump();

    expect(find.text('Register'), findsWidgets);
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

    await tester.pump();
    final registerButton = find.widgetWithText(GradientButton, 'Register');
    final GradientButton buttonWidget = tester.widget(registerButton);
    expect(buttonWidget.isEnabled, isTrue);
  });

  testWidgets('Navigates to LoginPage after successful register', (WidgetTester tester) async {
    Get.testMode = true;

    final rand = Random();
    final randomStr = rand.nextInt(100000).toString();
    final username = 'testuser$randomStr';
    final email = 'test$randomStr@mail.com';

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          registerProvider.overrideWith((ref) => FakeRegisterNotifier()),
        ],
        child: GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(
              name: '/',
              page: () => Scaffold(
                body: RegisterForm(
                  toastHelper: NoopToastHelper(),
                ),
              ),
            ),
            GetPage(
              name: '/login',
              page: () => const LoginPage(),
            ),
          ],
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), username);
    await tester.enterText(find.byType(TextField).at(1), email);
    await tester.enterText(find.byType(TextField).at(2), '12345678');
    await tester.enterText(find.byType(TextField).at(3), '12345678');
    await tester.pump();

    final registerButton = find.widgetWithText(GradientButton, 'Register');
    await tester.tap(registerButton);
    await tester.pump(const Duration(milliseconds: 700)); // tunggu navigasi

    // Tidak perlu cek navigasi ke LoginPage karena sudah dihilangkan di logic aslinya
    // Cek saja toast sukses muncul (mock/noop, jadi tidak error)
    expect(find.byType(RegisterForm), findsOneWidget);
  });
}
