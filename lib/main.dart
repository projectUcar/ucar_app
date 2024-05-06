import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/blocs.dart';
import 'src/helpers/notifications/push_notification_helper.dart';
import 'src/ucar_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationHelper.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc())
      ],
      child: const UcarApp())
  );
}
