import 'package:flutter/material.dart';

import '../theme/themes.dart';

enum DriverResponseStatus {
  missing("", Colors.transparent),
  successful("Solicitud enviada. Pronto te daremos respuesta", MyColors.success);

  final String message;
  final Color color;

  const DriverResponseStatus(this.message, this.color);
}