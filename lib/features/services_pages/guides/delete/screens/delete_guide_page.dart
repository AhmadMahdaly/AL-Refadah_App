import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/guides/delete/widgets/widgets/delete_guide_body.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:flutter/material.dart';

class DeleteGuidePage extends StatelessWidget {
  const DeleteGuidePage({required this.center, super.key});
  final GetGuidesCenterModel center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(
          title: '${center.fCenterName} - رقم ${center.fCenterNo}',
        ),
      ),
      body: DeleteGuideBody(center: center),
    );
  }
}
