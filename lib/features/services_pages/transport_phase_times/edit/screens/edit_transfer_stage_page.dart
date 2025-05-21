import 'package:flutter/material.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/edit/widgets/edit_transfer_stage_body.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';

class EditTransferStagePage extends StatelessWidget {
  const EditTransferStagePage({required this.center, super.key});
  final TransferStageGetCenterModel center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(
          title: '${center.fCenterName} - رقم ${center.fCenterNo}',
        ),
      ),
      body: EditTransferStageBody(center: center),
    );
  }
}
