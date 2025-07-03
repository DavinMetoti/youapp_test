import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youapp/core/network/api_client.dart';
import 'package:youapp/core/network/api_routes.dart';

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
      (ref) => RegisterNotifier(),
);

class RegisterState {
  final bool isLoading;
  final String? errorMessage;
  final bool success;

  const RegisterState({
    this.isLoading = false,
    this.errorMessage,
    this.success = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? success,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      success: success ?? this.success,
    );
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(const RegisterState());

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, success: false);

    try {
      final api = ApiClient();
      final response = await api.post(
        ApiRoutes.register,
        {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      print('Register API response: $response');

      final message = (response['message'] ?? '').toString().toLowerCase();
      final isSuccess = response['success'] == true ||
          response['token'] != null ||
          message.contains('created successfully');

      if (isSuccess) {
        print('Register success');
        state = state.copyWith(isLoading: false, success: true);
      } else {
        print('Register error: ${response['message'] ?? 'Registration failed'}');
        state = state.copyWith(
          isLoading: false,
          errorMessage: response['message'] ?? 'Registration failed',
        );
      }
    } catch (e) {
      print('Register exception: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred: ${e.toString()}',
      );
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  bool isValidUsername(String username) {
    return username.length >= 3;
  }
}
