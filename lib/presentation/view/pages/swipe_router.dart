import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

// PageView スワイプ処理のこと
// ref: https://zenn.dev/faucon/articles/e85f3744eb003c
@RoutePage()
class SwipePage extends StatelessWidget {
  const SwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 横に流れるような遷移
    return AutoTabsRouter.pageView(
      routes: [
        BooksTab(),
        ProfileTab(),
        // SettingsTab(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(context.topRoute.name),
            leading: AutoLeadingButton(),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(label: 'Books', icon: Text('a')),
              BottomNavigationBarItem(label: 'Profile', icon: Text('b')),
              // BottomNavigationBarItem(label: 'Settings', ...),
            ],
          ),
        );
      },
    );
  }
}
