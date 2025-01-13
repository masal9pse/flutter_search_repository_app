import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PostsPage extends StatelessWidget {
  const PostsPage({super.key, this.id = -1});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('posts'),
      ),
      body: Center(
        child: Text(id.toString()),
      ),
    );
  }
}
