import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/l10n/app_localizations.dart';
import 'core/di/dependancy_injection.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'features/settings/logic/setting_cubit.dart';

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create:  (context) => getIt<SettingCubit>(),
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            final cubit = context.read<SettingCubit>();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
              initialRoute: Routes.mapScreen,
              onGenerateRoute: AppRouter.generateRoute,
              locale: Locale(cubit.currentLanguageCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
