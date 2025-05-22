import 'package:flutter/material.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/auth/screens/confirm_login_screen.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    required this.code,
    required this.authCubit,
    required this.widget,
    super.key,
  });

  final String? code;
  final AuthCubit authCubit;
  final ConfirmLoginScreen widget;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'تأكيد',
      onTap: () async {
        if (code != null && code!.length == 6) {
          await authCubit.loginWithCode(code: code!);
        }
      },
    );
  }
}
