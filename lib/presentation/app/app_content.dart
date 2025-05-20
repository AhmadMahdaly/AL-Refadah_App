import 'package:alrefadah/core/init/build_bloc_providers.dart';
import 'package:alrefadah/core/routes/global_variable.dart';
import 'package:alrefadah/core/themes/app_theme.dart';
import 'package:alrefadah/core/themes/unfocus_scope.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// A widget that handles the app's content and state management.
class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusScope(context),
      child: MultiBlocProvider(
        providers: buildBlocProviders(),
        child: MaterialApp(
          navigatorKey: GlobalVariable.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: appTheme(context),
          title: appTitle,
          locale: const Locale('ar'), // هذا يحدد اللغة (والاتجاه rtl)
          supportedLocales: const [Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
