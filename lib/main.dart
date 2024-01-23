
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/gps/gps_bloc.dart';
import 'src/ucar_app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc())
      ],
      child: const UcarApp())
  );
}
