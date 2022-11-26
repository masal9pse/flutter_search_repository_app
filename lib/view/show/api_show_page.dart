import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';

class ApiShowPage extends StatelessWidget {
  const ApiShowPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.network(item!.owner.avatarUrl),
              title: Text(item!.name),
              subtitle: Text(item!.language ?? ''),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.star),
                Text(item!.stargazersCount.toString()),
                const SizedBox(width: 8),
                Icon(Icons.remove_red_eye),
                Text(item!.watchersCount.toString()),
                const SizedBox(width: 8),
                Icon(Icons.food_bank_sharp),
                Text(item!.forksCount.toString()),
                const SizedBox(width: 8),
                Icon(Icons.report),
                Text(item!.openIssuesCount.toString()),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
