import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.formKey,
    required this.isChecked,
    required this.authCubit,
    required TextEditingController userNameController,
    required TextEditingController passwordController,
    super.key,
  }) : _userNameController = userNameController,
       _passwordController = passwordController;

  final GlobalKey<FormState> formKey;
  final bool isChecked;
  final AuthCubit authCubit;
  final TextEditingController _userNameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'تسجيل الدخول',
      onTap: () async {
        if (formKey.currentState!.validate() && isChecked) {
          await authCubit.login(
            userName: _userNameController.text,
            password: _passwordController.text,
          );
        }
      },
    );
  }
}
