import 'package:flutter/material.dart';

import 'background.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Center(
            child: Text('MapScreen'),
          ),
        )
      ),
    );
  }
}