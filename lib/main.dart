import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Formz Example')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(child: MyForm()),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  MyForm({super.key, Random? seed}) : seed = seed ?? Random();

  final Random seed;

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _key = GlobalKey<FormState>();
  late MyFormState _state;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    setState(() {
      _state = _state.copyWith(status: FormSubmissionStatus.inProgress);
    });

    try {
      await _submitForm();
      _state = _state.copyWith(status: FormSubmissionStatus.success);
    } catch (_) {
      _state = _state.copyWith(status: FormSubmissionStatus.failure);
    }

    if (!mounted) return;

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    const successSnackBar = SnackBar(
      content: Text('Submitted successfully! 🎉'),
    );
    const failureSnackBar = SnackBar(
      content: Text('Something went wrong... 🚨'),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _state.status.isSuccess ? successSnackBar : failureSnackBar,
      );

    if (_state.status.isSuccess) _resetForm();
  }

  Future<void> _submitForm() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (widget.seed.nextInt(2) == 0) throw Exception();
  }

  void _resetForm() {
    _key.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    setState(() => _state = MyFormState());
  }

  @override
  void initState() {
    super.initState();
    _state = MyFormState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            key: const Key('myForm_emailInput'),
            controller: _emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
              helperText: 'A valid email e.g. joe.doe@gmail.com',
            ),
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            key: const Key('myForm_passwordInput'),
            controller: _passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              helperText:
                  'At least 8 characters including one letter and number',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
            ),
            validator: _validatePassword,
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 24),
          if (_state.status.isInProgress)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              key: const Key('myForm_submit'),
              onPressed: _onSubmit,
              child: const Text('Submit'),
            ),
        ],
      ),
    );
  }
}

enum FormSubmissionStatus { initial, inProgress, success, failure }

extension on FormSubmissionStatus {
  bool get isInProgress => this == FormSubmissionStatus.inProgress;

  bool get isSuccess => this == FormSubmissionStatus.success;
}

class MyFormState {
  MyFormState({this.status = FormSubmissionStatus.initial});

  final FormSubmissionStatus status;

  MyFormState copyWith({FormSubmissionStatus? status}) {
    return MyFormState(status: status ?? this.status);
  }
}

final _emailRegExp = RegExp(
  r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
);

final _passwordRegex =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

String? _validateEmail(String? value) {
  final v = value ?? '';
  if (v.isEmpty) {
    return 'Please enter an email';
  }
  if (!_emailRegExp.hasMatch(v)) {
    return 'Please ensure the email entered is valid';
  }
  return null;
}

String? _validatePassword(String? value) {
  final v = value ?? '';
  if (v.isEmpty) {
    return 'Please enter a password';
  }
  if (!_passwordRegex.hasMatch(v)) {
    return '''Password must be at least 8 characters and contain at least one letter and number''';
  }
  return null;
}

// import 'package:flutter/material.dart';
// import 'package:flutter_engineer_codecheck/l10n/app_localizations.dart';
// import 'package:flutter_engineer_codecheck/search_repo/presentation/views/screens/repo_search_screen.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// void main() {
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'GitHub Repo Search',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       home: const RepoSearchScreen(),
//     );
//   }
// }
