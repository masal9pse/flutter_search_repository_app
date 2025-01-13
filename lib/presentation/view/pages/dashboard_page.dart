// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

// @RoutePage()
// class DashboardPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Column(
//           children: [            
//             NavLink(label: 'Users', destination: const UsersRoute()),
//             NavLink(label: 'Posts', destination: const PostsRoute()),
//             // NavLink(label: 'Settings', destination: const SettingsRoute()),
//           ],
//         ),
//         Expanded(
//           // nested routes will be rendered here
//           child: AutoRouter(), // this is important
//         ),
//       ],
//     );
//   }
// }