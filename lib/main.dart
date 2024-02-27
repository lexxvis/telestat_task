import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:telestat_task/presentation/screens/main_screen.dart';
import 'package:telestat_task/utils/colors/app_colors.dart';
import 'package:telestat_task/utils/logger/error_logger.dart';

import 'config/themes/text_button_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled = false;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    ErrorLogger().logError(details);
  };

  PlatformDispatcher.instance.onError = (data, stackTrace) {
    ErrorLogger().log(data, stackTrace);
    return true;
  };

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (context) => LocaleModel(),
        child: Consumer<LocaleModel>(
            builder: (context, localeModel, child) =>
                MaterialApp(
                  localizationsDelegates: AppLocalizations
                      .localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: localeModel.locale,
                  theme: ThemeData(
                      textButtonTheme: textButtonTheme,
                      scaffoldBackgroundColor: AppColors.appBackground),
                  debugShowCheckedModeBanner: false,
                  home: const MainScreen(),
                ))
    );
  }
}

class LocaleModel extends ChangeNotifier {
  Locale? _locale;
  //Locale _locale = const Locale("ru");

  Locale? get locale => _locale;

  void set(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
