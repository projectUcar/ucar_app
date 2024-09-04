import 'package:url_launcher/url_launcher.dart';
import '../storage/auth_client.dart';
import '../blocs/blocs.dart';

mixin WhatsAppLauncher{

  static const String _baseUrl = 'https://wa.me/?';

  Future<void> sendMessageAsPassenger(String phoneNo, TripModel tripModel) async{
    final String? emitter = await AuthClient().session.then((session) => session?.name);
    final String message = '''Hola, ${tripModel.driverName.split(' ')[0]}.
    Soy $emitter, reservé un cupo en U-Car para el recorrido del día ${_dayFormatter(tripModel.departureDate)} 
    a la(s) ${tripModel.departureTime}, y quisiera concretar los detalles.''';
    await _sendMessage(phoneNo, message);
  }

  Future<void> sendMessageAsDriver(String phoneNo, TripModel tripModel) async{
    final String message = '''Hola. Soy ${tripModel.driverName.split(' ')[0]}, 
    el conductor del recorrido que reservaste en U-Car para el día ${_dayFormatter(tripModel.departureDate)} 
    a la(s) ${tripModel.departureTime}, y quisiera concretar los detalles.''';
    await _sendMessage(phoneNo, message);
  }

  Future<void> _sendMessage(String phoneNo, String message) async {
    final String encoded = Uri.encodeFull('${_baseUrl}phone=$phoneNo&text=$message');
    final Uri uri = Uri.parse(encoded);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  String _dayFormatter(DateTime dateTime){
    final DateTime currentDT = DateTime.now();
    switch (dateTime.difference(currentDT).inDays) {
      case -1: return 'de ayer';
      case 0: return 'de hoy';
      case 1: return 'de mañana';
      default: return '${dateTime.day} de ${months[dateTime.month]}';
    }
  }

  static const Map<int, String> months = {
    1 : 'enero',
    2 : 'febrero',
    3 : 'marzo',
    4 : 'abril',
    5 : 'mayo',
    6 : 'junio',
    7 : 'julio',
    8 : 'agosto',
    9 : 'septiembre',
    10 : 'octubre',
    11 : 'noviembre',
    12 : 'diciembre'
  };
}