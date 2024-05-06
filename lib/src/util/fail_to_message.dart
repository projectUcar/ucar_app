import 'package:dio/dio.dart';
import 'bad_response_model.dart';

extension FailToMessage on DioException{
  String getMessage(){
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return 'La petición de conexión tardó más de lo previsto';
      case DioExceptionType.sendTimeout:
        return 'La petición tardó más de lo previsto en enviar los datos';
      case DioExceptionType.receiveTimeout:
        return 'La petición tardó más de lo previsto en recibir datos';
      case DioExceptionType.badCertificate:
        return 'Certificado defectuoso';
      case DioExceptionType.badResponse:
        return BadResponseModel.fromAPI(response as Response<String>).message;
      case DioExceptionType.cancel:
        return 'La petición fue cancelada manualmente por el usuario';
      case DioExceptionType.connectionError:
        return 'Error de conexión';
      case DioExceptionType.unknown:
        return 'Fallo desconocido';
    }
  }
}