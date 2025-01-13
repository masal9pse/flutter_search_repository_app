import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

@RoutePage()
class DashboardRouterPage extends StatelessWidget {
  const DashboardRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const UsersRoute(),
        PostsRoute(),
        // SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(label: 'Users', icon: Text('a')),
            BottomNavigationBarItem(label: 'Posts', icon: Text('b')),
            // BottomNavigationBarItem(label: 'Settings', ...),
          ],
        );
      },
    );
  }
}