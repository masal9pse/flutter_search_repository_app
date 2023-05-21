import 'package:flutter_engineer_codecheck/application/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: PageInfoEnum.top.route,
        builder: ((context, state) => SearchApiListPage()),
      ),
      GoRoute(
        path: PageInfoEnum.show.route,
        builder: ((context, state) {
          final item = state.extra as Item;
          return ApiShowPage(
            id: item.id,
          );
        }),
      ),
    ],
  );