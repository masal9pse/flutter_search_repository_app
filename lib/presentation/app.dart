import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/route_observer.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.dart';
import 'package:flutter_engineer_codecheck/presentation/theme_extention.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(
        navigatorObservers: () => [MyObserver()],
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        extensions: [TextStyleExtension(color: Colors.red, fontSize: 30)],
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        extensions: [TextStyleExtension(color: Colors.blue, fontSize: 30)],
      ),
    );
  }
}
