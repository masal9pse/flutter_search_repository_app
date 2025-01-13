import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class UsersPage extends HookWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final a = context.router;
      final b = context.router.stack;
      final c = context.router.navigationHistory;      
      final k = AutoRouter.of(context);
      final t = 3;
      
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー画面'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // context.router.push(PostsRoute());
                // context.navigateTo(PostsRoute());
                context.router.navigate(PostsRoute());
                // context
              },
              child: Text('posts'),
            ),
            ElevatedButton(
              onPressed: () {
                // context.router.push(PostsRoute());
                // context.router.back();
                context.back();
              },
              child: Text('back'),
            ),
          ],
        ),
      ),
    );
  }
}
