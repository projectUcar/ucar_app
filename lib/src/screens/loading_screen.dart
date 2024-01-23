import 'package:flutter/material.dart';

import 'background.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Center(
            child: Text('LoadingScreen'),
          ),
        )
      ),
    );
  }
}