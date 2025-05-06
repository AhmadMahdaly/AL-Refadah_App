import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_appbar_title.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_body.dart';
import 'package:flutter/material.dart';

class ShowTransferStagePage extends StatelessWidget {
  const ShowTransferStagePage({required this.center, super.key});
  final TransferStageSharesGetCenterModel center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: ShowTransferStageAppbarTitle(center: center),
      ),
      body: ShowTransferStageBody(center: center),
    );
  }
}
