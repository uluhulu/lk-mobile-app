import 'package:flutter/material.dart';

class InitializeErrorPage extends StatelessWidget {
  final Object? error;
  const InitializeErrorPage({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Ошибка инициализации'),
      ),
      body: Center(
        child: Text('$error'),
      ),
    );
  }
}
