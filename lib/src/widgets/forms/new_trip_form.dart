import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:geocoding/geocoding.dart';

import '../../blocs/blocs.dart';
import '../../components/address_search.dart';
import '../../components/form_fields/field_types.dart';
import '../../components/form_fields/text_fields/ordinary_form_field.dart';
import '../../theme/themes.dart';
import '../../util/options/cities.dart';
import '../temporaries/async_progress_dialog.dart';

class NewTripForm extends StatefulWidget {
  const NewTripForm({super.key});

  @override
  State<NewTripForm> createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "NewTripKEY");

  NewTripCubit get cubit => BlocProvider.of<NewTripCubit>(context);

  DateTime? get departureDate => cubit.state.newTripModel.departureDate;

  late final FocusNode toUniversityFN, targetFN, vehicleFN, seatsFN, descriptionFN;

  late final TextEditingController targetController;

  @override
  void initState() {
    toUniversityFN = FocusNode();
    targetFN = FocusNode();
    vehicleFN = FocusNode();
    seatsFN = FocusNode();
    descriptionFN = FocusNode();
    targetController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    toUniversityFN.dispose();
    targetFN.dispose();
    vehicleFN.dispose();
    seatsFN.dispose();
    descriptionFN.dispose();
    targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTripCubit, NewTripState>(
      bloc: cubit,
      builder: (context, newTripState) => Form(
        key: formKey,
        autovalidateMode: newTripState.autoValidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("¿Vas para la U?", style: TextStyle(color: MyColors.textOrange, fontSize: Fontsizes.bodyTextFontSize + 2)),
                cupertino.CupertinoSwitch(
                  focusNode: toUniversityFN,
                  value: newTripState.toU,
                  activeColor: MyColors.purpleTheme,
                  onChanged: cubit.updateToU
                )
              ],
            ),
            TextField(
              controller: targetController,
              style: CustomStyles.whiteStyle,
              focusNode: targetFN,
              textCapitalization: TextCapitalization.words,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                hintText: 'Busca tu dirección',
                prefixIcon: Icon(Icons.streetview),
              ),
              onTap: () async {
                final Placemark? placemark = await showSearch(
                  context: context,
                  delegate: AddressSearch(),
                );
                if (placemark != null) {
                  targetController.text = '${placemark.name}, ${placemark.street}, ${placemark.locality}';
                  cubit.updateCity(Cities.fromString(placemark.locality));
                  cubit.updateTarget(placemark.name);
                  //vehicleFN.requestFocus();
                  seatsFN.requestFocus();
                }
              },
            ),
            // DropdownButtonFormField<String>(
            //   focusNode: vehicleFN,
            //   items: cubit.plates.map((e) => DropdownMenuItem<String>(child: Text(e))).toList(),
            //   onChanged: (s) {
            //     debugPrint(s.toString());
            //     cubit.updateVehicle(s);
            //     seatsFN.requestFocus();
            //   },
            //   dropdownColor: MyColors.secondary,
            //   menuMaxHeight: 142.0,
            //   value: newTripState.newTripModel.vehicle?.plate,
            //   style: CustomStyles.whiteStyle.copyWith(fontSize: 16),
            //   validator: newTripState.vehicleValidator,
            //   icon: const Icon(Icons.arrow_drop_down_rounded, color: MyColors.textGrey, size: 28),
            //   borderRadius: const BorderRadius.all(Radius.circular(20)),
            //   decoration: const InputDecoration(labelText: "Vehículo", hintText: "Elige un vehículo"),
            //   autovalidateMode: newTripState.autoValidateMode,
            // ),
            //ASIENTOS DISPONIBLES
            SpinBox(
              focusNode: seatsFN,
              min: 1,
              max: newTripState.newTripModel.vehicle?.seats?.toDouble() ?? 4,
              step: 1,
              value: 1,
              textStyle: const TextStyle(color: MyColors.purpleTheme),
              validator: newTripState.seatsValidator,
              iconColor: const MaterialStatePropertyAll(MyColors.purpleTheme),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Núm. Asientos", hintText: "Ej. 6"),
              direction: Axis.vertical,
              onChanged: (s) => cubit.updateSeats(s.toInt()),
            ),
            cupertino.CupertinoButton(
              onPressed: () {
                final currentDT = DateTime.now();
                _showDialog(
                cupertino.CupertinoDatePicker(
                  initialDateTime: currentDT.add(Duration(minutes: cubit.state.toU ? 40: 10)),
                  minimumDate: currentDT.add(Duration(minutes: cubit.state.toU ? 40: 10)),
                  maximumDate: currentDT.add(const Duration(days: 7)),
                  use24hFormat: false,
                  onDateTimeChanged: (s) {
                    cubit.updateDepartureDate(s);
                    cubit.updateDepartureTime(s.format(r'g\:i A'));
                  },
                ),
              );
              },
              child: Text(dateTimeShowFormat, style: const TextStyle(fontSize: 22.0)),
            ),
            //DESCRIPCION
            OrdinaryFormField(
              onChanged: cubit.updateDescription,
              validator: newTripState.descriptionValidator,
              currentValue: newTripState.newTripModel.description,
              focusNode: descriptionFN,
              nextFocusNode: null,
              maxLines: 5,
              fieldType: FieldTypes.description,
              autovalidateMode: newTripState.autoValidateMode,
              maxLength: 120,
            ),
            FloatingActionButton.extended(
              onPressed: () async{
                cubit.updateSubmitted(true);
                if (formKey.currentState!.validate() && newTripState.isValid) {
                  AsyncProgressDialog.show(context);
                  final bool successful = await cubit.submit();
                  if(context.mounted){
                    if (successful) {
                      AsyncProgressDialog.dismiss(context);
                      Navigator.pop<bool>(context, successful);
                    } else {
                      AsyncProgressDialog.dismiss(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text("Error en el envío de solicitud. Inténtalo más tarde", style: TextStyle(color: MyColors.textWhite)), backgroundColor: Colors.red.shade400)
                      );
                    }
                  }
                }
              },
              backgroundColor: MyColors.purpleTheme.withOpacity(0.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: const BorderSide(color: MyColors.purpleTheme)),
              label: const Text("Enviar solicitud", style: TextStyle(color: MyColors.textWhite, fontSize: Fontsizes.subTitleFontSize))
            )
          ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: e)).toList()
        ),
      ),
    );
  }

  String get dateTimeShowFormat => departureDate != null ? '${departureDate?.month}-${departureDate?.day}-${departureDate?.year} ${departureDate?.hour}:${departureDate?.minute}' : '00-00-0000 00:00';

  void _showDialog(Widget child) {
    cupertino.showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: MyColors.purpleTheme,
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}