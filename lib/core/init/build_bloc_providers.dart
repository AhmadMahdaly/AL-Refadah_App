import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/repo/home_repo.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/repo/buses_repo.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/repo/buses_travel_repo.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/repo/transfer_stage_shares_repo.dart';
import 'package:alrefadah/presentation/app/shared_cubit/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Builds the list of BlocProviders for the app
List<BlocProvider> buildBlocProviders() {
  return [
    /// Auth
    BlocProvider<AuthCubit>(create: (context) => AuthCubit()),

    /// Home
    BlocProvider<HomeCubit>(create: (context) => HomeCubit(GetHomePageRepo())),

    /// Transport Phase Times
    BlocProvider<TransferStageSharesCubit>(
      create: (context) => TransferStageSharesCubit(TransferStageSharesRepo()),
    ),

    /// Oprating Commands
    BlocProvider<OpratingCommandsCubit>(
      create: (context) => OpratingCommandsCubit(),
    ),

    /// Guides
    BlocProvider<GuidesCubit>(create: (context) => GuidesCubit()),

    /// Buses
    BlocProvider<BusesCubit>(create: (context) => BusesCubit(BusesRepo())),

    /// Buses Travel
    BlocProvider<BusTravelCubit>(
      create: (context) => BusTravelCubit(BusesTravelRepo()),
    ),

    /// Get Current Location
    BlocProvider<GetCurrentLocationCubit>(
      create: (context) => GetCurrentLocationCubit(),
    ),
  ];
}
