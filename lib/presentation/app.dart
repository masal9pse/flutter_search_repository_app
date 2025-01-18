import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
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
    // deeplink check
    // return MaterialApp(
    //   home: MyHomePage(),
    // );

    // return MaterialApp.router(
    return CupertinoApp.router(
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
      // theme: ThemeData(
      //   colorSchemeSeed: Colors.blue,
      //   extensions: [TextStyleExtension(color: Colors.red, fontSize: 30)],
      // ),
      // darkTheme: ThemeData(
      //   colorSchemeSeed: Colors.blue,
      //   brightness: Brightness.dark,
      //   extensions: [TextStyleExtension(color: Colors.blue, fontSize: 30)],
      // ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  String? catchLink;
  String? parameter;

  @override
  void initState() {
    super.initState();
    initAppLinks();
  }

  Future<void> initAppLinks() async {
    // AppLinksインスタンスを作成
    _appLinks = AppLinks();

    // Deep Linkのリッスンを開始
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        // キャッチしたリンクを処理
        catchLink = uri.toString();
        parameter = getQueryParameter(uri);
        setState(() {});
      }
    }, onError: (err) {
      print(err);
    });

    // アプリが再開されたときに取得したリンクを処理
    // final initialUri = await _appLinks.getInitialAppLink();
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      catchLink = initialUri.toString();
      parameter = getQueryParameter(initialUri);
      setState(() {});
    }
  }

  String? getQueryParameter(Uri uri) {
    // flutterUniversity://user/?name=matsumaru のパラメータを取得
    return uri.queryParameters['name'];
  }

  @override
  void dispose() {
    // リソースを解放
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'リンク：$catchLink',
              // style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'パラメーター：$parameter',
              // style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
