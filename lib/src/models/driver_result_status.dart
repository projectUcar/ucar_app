import 'package:flutter/material.dart';

import '../theme/themes.dart';

enum DriverResultStatus {
  missing("", Colors.transparent),
  successful("Solicitud enviada. Pronto te daremos respuesta", MyColors.success);

  final String message;
  final Color color;

  const DriverResultStatus(this.message, this.color);
}