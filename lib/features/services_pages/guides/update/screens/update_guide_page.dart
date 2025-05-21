import 'package:flutter/material.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/update/widgets/update_guide_body.dart';

class UpdateGuidePage extends StatelessWidget {
  const UpdateGuidePage({
    required this.center,
    required this.employe,
    super.key,
  });
  final GetGuidesCenterModel center;
  final GetGuidesModel employe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(
          title: '${center.fCenterName} - رقم ${center.fCenterNo}',
        ),
      ),
      body: UpdateGuideBody(employe: employe),
    );
  }
}
