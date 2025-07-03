import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youapp/core/network/api_client.dart';
import 'package:youapp/core/network/api_routes.dart';
import 'package:youapp/common/services/secure_storage_service.dart';
import 'login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState.initial());

  Future<bool> login({
    required String userOrEmail,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final api = ApiClient();
      final isEmail = userOrEmail.contains('@');
      final payload = {
        'username': isEmail ? "" : userOrEmail,
        'email': isEmail ? userOrEmail : "",
        'password': password.isNotEmpty ? password : "",
      };
      final response = await api.post(ApiRoutes.login, payload);

      if (response['access_token'] != null) {
        final storage = SecureStorageService();
        await storage.saveToken(response['access_token']);
        if (isEmail) {
          await storage.saveUserCredential(email: userOrEmail);
        } else {
          await storage.saveUserCredential(username: userOrEmail);
        }

        state = state.copyWith(isLoading: false, errorMessage: null);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response['message'] ?? 'Login failed',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Login error: ${e.toString()}',
      );
      return false;
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
