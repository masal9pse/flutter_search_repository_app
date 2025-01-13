import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Column(
        //   children: [
        //     NavLink(label: 'Users', destination: const UsersRoute()),
        //     NavLink(label: 'Posts', destination: const PostsRoute()),
        //     // NavLink(label: 'Settings', destination: const SettingsRoute()),
        //   ],
        // ),
        Expanded(
          // nested routes will be rendered here
          child: AutoRouter(), // this is important
        ),
      ],
    );
  }
}


//Note NavLink is just a button that calls router.push(destination).

class NavLink extends StatelessWidget {
  const NavLink({super.key, required this.label, required this.destination});

  final String label;
  final dynamic destination;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // context.router.push(destination); // ボタンを押すたび積み上がっていく
        context.navigateTo(destination); // 
      },
      child: Text(label),
    );
  }
}