import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../models/vehicle.dart';
import '../../util/options/document_types.dart';
import '../../util/regex_comparison.dart';
import '../token_validation.dart';

part 'driver_state.dart';
class DriverCubit extends Cubit<DriverState> with TokenValidation<DriverState>{
  DriverCubit() : super(DriverState.initial());
  final VehiclesHelper _helper = VehiclesHelper();

  void _updateState(DriverState newState){
    emit(newState);
  }

  Future<bool> _saveDocuments(String token) async{
    final saveDriver = await _helper.saveDocument(token, jsonEncode(state.driverToJson()));
    if (state.vehicle.isOwner == false) {
      final saveOwner = await _helper.saveDocument(token, jsonEncode(state.ownerToJson()));
      return saveDriver && saveOwner;
    }
    return saveDriver;
  }

  Future<bool> submit() async{
    final token = await verifyToken();
    final sendVehicle = await _helper.addVehicleRequest(token!, jsonEncode(state.vehicle.toJson()));
    final driversResult = await _saveDocuments(token).then((value) async => value == true ? await _helper.sendDriverRequest(token) : value);
    return driversResult && sendVehicle;
  }

  void updateDocumentType(String? s) => _updateState(state.copyWith(documentType: s));
  void updateDocValue(String? s) => _updateState(state.copyWith(docValue: s));
  void updateBrand(String? s) => _updateState(state.copyWith(brand: s));
  void updateModel(String? s) => _updateState(state.copyWith(model: s));
  void updateLine(String? s) => _updateState(state.copyWith(line: s));
  void updatePlate(String? s) => _updateState(state.copyWith(plate: s));
  void updateColor(String? s) => _updateState(state.copyWith(color: s));
  void updateSeats(int? s) => _updateState(state.copyWith(seats: s));
  void updateDoors(int? s) => _updateState(state.copyWith(doors: s));
  void updateIsOwner(bool? s) => _updateState(state.copyWith(isOwner: s, documentTypeOwner: state.documentType, documentNumberOwner: (s == false) ? '' : state.docValue));
  void updateDocumentTypeOwner(String? s) => _updateState(state.copyWith(documentTypeOwner: s));
  void updateDocumentNumberOwner(String? s) => _updateState(state.copyWith(documentNumberOwner: s));
  void updateSubmitted(bool? s) => _updateState(state.copyWith(submitted: s));

  void updateTypes(String? s) => _updateState(state.copyWith(documentType: s, documentTypeOwner: s));
  void updateValues(String? s) => _updateState(state.copyWith(docValue: s, documentNumberOwner: s));

}
