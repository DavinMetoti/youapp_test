class RegisterState {
  final String? email;
  final String? password;
  final String? confirmPassword;
  final bool isLoading;
  final String? errorMessage;

  RegisterState({
    this.email,
    this.password,
    this.confirmPassword,
    this.isLoading = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}