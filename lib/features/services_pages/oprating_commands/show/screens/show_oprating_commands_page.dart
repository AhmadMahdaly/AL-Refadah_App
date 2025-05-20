import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/show/widgets/show_oprating_commands_body.dart';
import 'package:flutter/material.dart';

class ShowOpratingCommandsPage extends StatelessWidget {
  const ShowOpratingCommandsPage({required this.data, super.key});
  final GetAllOperatingsModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(title: 'أمر تشغيل ${data.fOperatingNo}'),
      ),
      body: ShowOpratingCommandsBody(data: data),
    );
  }
}
