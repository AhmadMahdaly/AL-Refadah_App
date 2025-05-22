import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/edit/widgets/edit_oprating_body.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:flutter/material.dart';

class EditOpratingCommands extends StatelessWidget {
  const EditOpratingCommands({required this.data, super.key});
  final GetAllOperatingsModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(title: 'تعديل أمر التشغيل ${data.fOperatingNo}'),
      ),
      body: EditOpratingBody(data: data),
    );
  }
}
