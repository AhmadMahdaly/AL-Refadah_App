import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/transport_stage/cubit/stage_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_stage/repo/stage_repo.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_body.dart';

class StagePage extends StatelessWidget {
  const StagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StageCubit>(
      create: (context) => StageCubit(StageRepo()),
      child: Scaffold(
        appBar: AppBar(
          leading: const LeadingIcon(),
          title: const TitleAppBar(title: 'مراحل النقل'),
        ),
        body: const StageBody(),
      ),
    );
  }
}
