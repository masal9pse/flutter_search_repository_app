import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';

class MockSearchApiNotifier extends SearchApiNotifier {
  @override
  Future<SearchApiModel?> build() async {
    return SearchApiModel.mockData;
  }
}