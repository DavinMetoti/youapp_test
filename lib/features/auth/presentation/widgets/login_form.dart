import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/features/auth/presentation/controllers/login_controller.dart';
import 'package:youapp/features/auth/presentation/providers/login_provider.dart';
import 'package:youapp/common/widgets/password_field.dart';
import 'package:youapp/common/widgets/text_field.dart';
import 'package:youapp/common/widgets/gradient_button.dart';
import 'package:youapp/common/utils/toast_helper.dart';

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

class LoginForm extends ConsumerStatefulWidget {
  final IToastHelper? toastHelper;
  const LoginForm({super.key, this.toastHelper});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final controller = LoginController();

  IToastHelper get _toast => widget.toastHelper ?? DefaultToastHelper();

  @override
  void initState() {
    super.initState();
    controller.username.addListener(_onInputChanged);
    controller.password.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    // Hanya panggil setState jika widget masih terpasang
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.username.removeListener(_onInputChanged);
    controller.password.removeListener(_onInputChanged);
    controller.dispose();
    super.dispose();
  }

  void _submit() async {
    final notifier = ref.read(loginProvider.notifier);

    final userOrEmail = controller.username.text.trim();
    final password = controller.password.text;

    if (userOrEmail.isEmpty || password.isEmpty) {
      _toast.showError(context, 'Please fill all fields');
      return;
    }

    final success = await notifier.login(
      userOrEmail: userOrEmail,
      password: password,
    );

    if (success) {
      _toast.showSuccess(context, 'Login success');
    } else {
      final errorMsg = ref.read(loginProvider).errorMessage ?? 'Login failed';
      _toast.showError(context, errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    // Ambil nilai langsung dari controller agar selalu up-to-date
    final userOrEmail = controller.username.text.trim();
    final password = controller.password.text;
    final isInputFilled = userOrEmail.isNotEmpty && password.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: controller.username,
          hintText: 'Username or Email',
        ),
        const SizedBox(height: 16),
        PasswordField(
          controller: controller.password,
          hintText: 'Password',
        ),
        const SizedBox(height: 24),
        GradientButton(
          onPressed: (state.isLoading || !isInputFilled) ? null : _submit,
          text: 'Login',
          isEnabled: isInputFilled && !state.isLoading,
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
