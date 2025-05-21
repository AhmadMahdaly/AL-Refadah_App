import 'package:flutter/material.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/add/widgets/add_oprating_command_body.dart';

class AddOpratingCommandsPage extends StatelessWidget {
  const AddOpratingCommandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'إضافة أمر تشغيل'),
      ),
      body: const AddOpratingCommandBody(),
    );
  }
}
