import 'package:flutter_test/flutter_test.dart';
import 'package:youapp/features/auth/presentation/providers/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('LoginNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is not loading and has no error', () {
      final state = container.read(loginProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, null);
    });

    test('login with empty credentials returns false and sets error', () async {
      final notifier = container.read(loginProvider.notifier);
      final success = await notifier.login(userOrEmail: '', password: '');
      final state = container.read(loginProvider);

      expect(success, false);
      expect(state.isLoading, false);
      expect(state.errorMessage, isNotNull);
    });
  });
}
