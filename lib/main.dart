import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/core/di/dependancy_injection.dart';
import 'package:google_maps/core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'features/settings/logic/setting_cubit.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await dotenv.load(fileName: ".env");
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) => getIt<SettingCubit>()..getSavedLanguage(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          final cubit = context.read<SettingCubit>();
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
              initialRoute: Routes.splashScreen,
              onGenerateRoute: AppRouter.generateRoute,
              locale: Locale(cubit.currentLanguageCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
