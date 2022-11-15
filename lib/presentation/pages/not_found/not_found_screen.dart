import 'package:flutter/material.dart';

/// Страница не найдена
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Страница не найдена'),
      ),
    );
  }
}
