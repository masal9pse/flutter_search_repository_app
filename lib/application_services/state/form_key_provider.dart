import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formKeyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());