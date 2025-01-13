import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class PostsPage extends HookWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final a = context.router.stack;
      final t = 3;
    },[]);
    return Scaffold(
      appBar: AppBar(
        title: Text('ポスト画面'),
      ),
      body: Center(child: Column(
        children: [
          ElevatedButton(onPressed: () {
            context.navigateTo(UsersRoute());
          }, child: Text('to User'))
        ],
      )),
    );
  }
}