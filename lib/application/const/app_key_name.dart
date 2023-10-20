import 'package:flutter/material.dart';

class AppKeyName {
  static const topPageSearchTextField = Key('top_page_search_text_field');
  static const searchElevatedButton = Key('search_elevated_button');
  static const snackBar = Key('snack_bar');

  static Key responseDetailCard(int id) => Key('response_detail_card_$id');
}
