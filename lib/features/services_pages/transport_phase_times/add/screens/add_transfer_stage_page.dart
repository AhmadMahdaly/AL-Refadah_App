import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/widgets/add_transfer_stage_body.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTransferStagePage extends StatelessWidget {
  const AddTransferStagePage({required this.center, super.key});
  final TransferStageSharesGetCenterModel center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${center.fCenterName} - رقم ${center.fCenterNo}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),
      ),
      body: AddTransferStageBody(center: center),
    );
  }
}
