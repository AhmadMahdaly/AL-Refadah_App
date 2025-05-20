import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_body.dart';
import 'package:flutter/material.dart';

class ShowTransferStagePage extends StatelessWidget {
  const ShowTransferStagePage({required this.center, super.key});
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
      body: ShowTransferStageBody(center: center),
    );
  }
}
