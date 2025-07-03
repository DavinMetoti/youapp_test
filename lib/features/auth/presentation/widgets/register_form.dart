import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/common/widgets/text_field.dart';
import 'package:youapp/common/widgets/password_field.dart';
import 'package:youapp/features/auth/presentation/providers/register_provider.dart';
import 'package:youapp/common/utils/toast_helper.dart';
import 'package:youapp/common/widgets/gradient_button.dart';

abstract class IToastHelper {
  void showError(BuildContext context, String message);
  void showSuccess(BuildContext context, String message);
}

class DefaultToastHelper implements IToastHelper {
  @override
  void showError(BuildContext context, String message) {
    ToastHelper.showError(context, message);
  }

  @override
  void showSuccess(BuildContext context, String message) {
    ToastHelper.showSuccess(context, message);
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  final IToastHelper? toastHelper;
  const RegisterForm({super.key, this.toastHelper});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  IToastHelper get _toast => widget.toastHelper ?? DefaultToastHelper();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onInputChanged);
    _emailController.addListener(_onInputChanged);
    _passwordController.addListener(_onInputChanged);
    _confirmPasswordController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _usernameController.removeListener(_onInputChanged);
    _emailController.removeListener(_onInputChanged);
    _passwordController.removeListener(_onInputChanged);
    _confirmPasswordController.removeListener(_onInputChanged);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    final notifier = ref.read(registerProvider.notifier);
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (!notifier.isValidUsername(username)) {
      _toast.showError(context, 'Username must be at least 3 characters');
      return;
    }
    if (!notifier.isValidEmail(email)) {
      _toast.showError(context, 'Invalid email format');
      return;
    }
    if (!notifier.isValidPassword(password)) {
      _toast.showError(context, 'Password must be at least 6 characters');
      return;
    }
    if (password != confirmPassword) {
      _toast.showError(context, 'Passwords do not match');
      return;
    }

    final currentContext = context;
    await notifier.register(username: username, email: email, password: password);

    if (!mounted) return;

    final state = ref.read(registerProvider);

    if (state.success) {
      _toast.showSuccess(currentContext, 'Registration successful');
    } else if (state.errorMessage != null) {
      _toast.showError(currentContext, state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);

    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final isInputFilled = username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Register',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 24),
        AppTextField(
          controller: _usernameController,
          hintText: 'Username',
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        PasswordField(
          controller: _passwordController,
          hintText: 'Password',
        ),
        const SizedBox(height: 16),
        PasswordField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
        ),
        const SizedBox(height: 24),
        GradientButton(
          onPressed: (state.isLoading || !isInputFilled) ? null : _submit,
          text: 'Register',
          isEnabled: isInputFilled && !state.isLoading,
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
