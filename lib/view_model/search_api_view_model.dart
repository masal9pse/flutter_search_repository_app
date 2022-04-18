import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/extention/custom_exception.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';

class SearchApiViewModel with ChangeNotifier {
  SearchApiViewModel(this.searchApiService);
  final SearchApiService searchApiService;
  SearchApiModelStruct? _searchApiModelStruct;
  SearchApiModelStruct? get searchApiModelStruct => _searchApiModelStruct;
  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;
  final formController = TextEditingController();

  set isEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
  }

  set searchApiModelStruct(SearchApiModelStruct? value) {
    _searchApiModelStruct = value;
    notifyListeners();
  }

  /// API 通信 と View層への通知
  Future<SearchApiModelStruct?> fetchSearchApiModelStruct(String text) async {
    try {
      isEnabled = false;
      final fetchInfo = await searchApiService.getApiListInfo(text);
      searchApiModelStruct = fetchInfo;
      return fetchInfo;
    } on NotModifiedException catch (_) {
      throw NotModifiedException();
    } on BadRequestException catch (_) {
      throw BadRequestException();
    } on ServerProblemException catch (_) {
      throw ServerProblemException();
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } on Exception catch (e) {
      throw Exception(e.toString());
    } finally {
      isEnabled = true;
    }
  }
}