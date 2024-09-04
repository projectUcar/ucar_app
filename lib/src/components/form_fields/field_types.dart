import 'package:flutter/material.dart';
import 'package:ucar_app/src/util/options/cities.dart';
import '../../util/options/document_types.dart';
import '../../util/options/enum_formatter.dart';
import '../../util/options/groups.dart';
import '../../util/options/genders.dart';

enum FieldTypes {
  id(labelText: 'ID', hintText: 'Ej. 372781', textInputType: TextInputType.number, prefixIcon: Icons.numbers_rounded),
  name(labelText: 'Nombre(s)', hintText: 'Ej. Juan Pablo', textInputType: TextInputType.text, prefixIcon: Icons.person),
  lastname(labelText: 'Apellido(s)', hintText: 'Ej. Amaya Duarte', textInputType: TextInputType.text, prefixIcon: Icons.person),
  phonenumber(labelText: 'Teléfono', hintText: 'Ej. 313626939', textInputType: TextInputType.number, prefixIcon: Icons.phone),
  email(labelText: 'Email', hintText: 'Ej. pepito.perez.2016@upb.edu.co', textInputType: TextInputType.emailAddress, prefixIcon: Icons.email_rounded),
  password(labelText: 'Contraseña', hintText: 'Crea una contraseña fuerte', textInputType: TextInputType.visiblePassword, prefixIcon: Icons.lock_rounded),
  confirmation(labelText: 'Confirmación de contraseña', hintText: 'Digita el mismo valor anterior', textInputType: TextInputType.visiblePassword, prefixIcon: Icons.lock_outline_rounded),
  groups(labelText: 'Colectivo', hintText: 'Elige tu colectivo', prefixIcon: Icons.groups, textInputType: null),
  genders(labelText: 'Género', hintText: 'Elige tu género', prefixIcon: Icons.male_rounded, textInputType: null),
  cities(labelText: 'Ciudad', hintText: 'Elige una ciudad', prefixIcon: Icons.location_city_rounded, textInputType: null),
  loginPassword(labelText: 'Contraseña', hintText: '', textInputType: TextInputType.visiblePassword, prefixIcon: Icons.lock_rounded),
  docType(labelText: 'Tipo de decumento', hintText: 'Elige el tipo', prefixIcon: Icons.badge_rounded, textInputType: null),
  docNumber(labelText: 'Num. de decumento', hintText: 'Ej. 1001010110 ó 1001010110-1', prefixIcon: Icons.numbers_rounded, textInputType: TextInputType.datetime),
  vehicleBrand(labelText: 'Marca', hintText: 'Ej. Renault', prefixIcon: Icons.branding_watermark_outlined, textInputType: TextInputType.name),
  vehicleModel(labelText: 'Modelo', hintText: 'Ej. 2012', prefixIcon: Icons.date_range, textInputType: TextInputType.number),
  vehicleLine(labelText: 'Línea', hintText: 'Ej. Clio', prefixIcon: Icons.featured_play_list, textInputType: TextInputType.visiblePassword),
  vehiclePlate(labelText: 'Placa', hintText: 'Ej. AAA999', prefixIcon: Icons.numbers, textInputType: TextInputType.visiblePassword),
  vehicleColor(labelText: 'Color de vehículo', hintText: 'Ej. Vinotinto', prefixIcon: Icons.palette_outlined, textInputType: TextInputType.name),
  description(labelText: 'Descripción', hintText: 'Agrega una descripción', prefixIcon: null, textInputType: TextInputType.multiline),
  target(labelText: 'Dirección', hintText: 'Busca tu dirección', prefixIcon: Icons.streetview, textInputType: TextInputType.streetAddress);

  final String _labelText;
  final String? _hintText;
  final IconData? _prefixIcon;
  final TextInputType? _textInputType;

  const FieldTypes({required String labelText, required String? hintText, required TextInputType? textInputType, required IconData? prefixIcon})
  : _labelText = labelText,
    _hintText = hintText,
    _textInputType = textInputType,
    _prefixIcon = prefixIcon;

  String get getLabelText => _labelText;
  String? get getHintText => _hintText;
  TextInputType? get getTextInputType => _textInputType;
  IconData? get getPrefixIcon => _prefixIcon;

}

enum SelectionFieldTypes<T extends Enum> {
  groups(items: Groups.values),
  genders(items: Genders.values),
  cities(items: Cities.values),
  docTypes(items: DocumentTypes.values);
  
  final List<T> _items;

  const SelectionFieldTypes({required List<T> items})
  : _items = items;

  List<String> get getItems => _items.fromEnum();
}