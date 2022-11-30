import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/view/show/api_show_page.dart';

class ApiResponseCard extends StatelessWidget {
  ApiResponseCard({Key? key, this.item}) : super(key: key);
  final Item? item;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: item != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.network(item!.owner.avatarUrl),
                    title: Text(item!.name),
                    subtitle: Text(item!.language ?? ''),
                    onTap: () {
                      Navigator.of(context).pushNamed('/show', arguments: item);
                    },
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
              )
            : Container(),
      ),
    );
  }
}
