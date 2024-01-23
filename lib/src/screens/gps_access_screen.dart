import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../theme/colors.dart';
import '../theme/custom_styles.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            debugPrint('GpsState: $state');
            return !state.enabledGPS ? const _EnambleGpsMessage() : const _AccessButton();
          }
        )
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Habilita el acceso a GPS', style: TextStyle(color: MyColors.textOrange),),
        FloatingActionButton.extended(
          foregroundColor: MyColors.primary,
          backgroundColor: MyColors.orangeDark,
          splashColor: Colors.transparent,
          onPressed: () {
            
          },
          label: Text('Solicitar acceso', style: CustomStyles.boldStyle.copyWith(fontSize: 20))),
      ].map((child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: child,
      )).toList(),
    );
  }
}

class _EnambleGpsMessage extends StatelessWidget {
  const _EnambleGpsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'GPSAccessScreen',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
