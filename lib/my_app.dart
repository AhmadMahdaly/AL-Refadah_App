import 'package:alrefadah/cubit/auth_cubit/auth_cubit.dart';
import 'package:alrefadah/screens/splash_screen/splash_screen.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,

      /// Remove focus from any input element
      child: GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },
        child: BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AL Refadah',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: kScaffoldBackgroundColor,
                iconTheme: IconThemeData(color: kMainColor),
              ),
              scaffoldBackgroundColor: kScaffoldBackgroundColor,
              textTheme: Theme.of(
                context,
              ).textTheme.apply(fontFamily: 'GE SS Two'),
            ),

            /// Localizations
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
