import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

@RoutePage()
class UpperDashboardRouterPage extends StatelessWidget {
  const UpperDashboardRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        BooksTab(),
        ProfileTab(),
        SettingsTab(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(context.topRoute.name),
            leading: AutoLeadingButton(),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: '1', icon: Icon(Icons.abc)),
                Tab(text: '2', icon: Icon(Icons.abc)),
                Tab(text: '3', icon: Icon(Icons.abc)),
              ],
            ),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(label: 'Books', icon: Text('abc')),
              BottomNavigationBarItem(label: 'Profile', icon: Text('ddd')),
              BottomNavigationBarItem(label: 'Settings',icon: Text('settings')),
            ],
          ),
        );
      },
    );
  }
}
