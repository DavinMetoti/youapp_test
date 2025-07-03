import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/features/auth/presentation/providers/register_provider.dart';

void main() {
  final notifier = RegisterNotifier();

  group('RegisterProvider validation', () {
    test('valid username', () {
      expect(notifier.isValidUsername('abc'), true);
      expect(notifier.isValidUsername('ab'), false);
    });

    test('valid email', () {
      expect(notifier.isValidEmail('a@b.com'), true);
      expect(notifier.isValidEmail('invalid'), false);
    });

    test('valid password', () {
      expect(notifier.isValidPassword('12345678'), true);
      expect(notifier.isValidPassword('1234567'), false);
    });
  });
}

