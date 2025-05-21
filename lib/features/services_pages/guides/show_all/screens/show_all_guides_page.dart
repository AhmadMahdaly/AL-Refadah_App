import 'package:flutter/material.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/show_all/widgets/show_all_guides_body.dart';

class ShowAllGuidesPages extends StatelessWidget {
  const ShowAllGuidesPages({required this.center, super.key});
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
      body: ShowAllGuidesBody(center: center),
    );
  }
}
