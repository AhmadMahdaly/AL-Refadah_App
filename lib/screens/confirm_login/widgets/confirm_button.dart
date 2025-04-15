import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/cubit/auth_cubit/auth_cubit.dart';
import 'package:alrefadah/screens/confirm_login/confirm_login_screen.dart';
import 'package:flutter/material.dart';

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
          await authCubit.loginWithCode(
            phoneNumber: widget.phoneNumber,
            identityNumber: widget.identityNumber,
            code: code!,
          );
        }
      },
    );
  }
}
