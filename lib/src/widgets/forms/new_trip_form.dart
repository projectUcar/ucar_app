import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../../blocs/blocs.dart';
import '../../components/form_fields/field_types.dart';
import '../../components/form_fields/selection_fields/selection_form_field.dart';
import '../../components/form_fields/text_fields/ordinary_form_field.dart';
import '../../config/size_config.dart';
import '../../theme/themes.dart';
import '../../util/options/cities.dart';
import '../temporaries/async_progress_dialog.dart';

class NewTripForm extends StatefulWidget {
  const NewTripForm({super.key, required NewTripCubit cubit}) : _cubit = cubit;
  final NewTripCubit _cubit;

  @override
  State<NewTripForm> createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "DriverFormKEY");

  NewTripCubit get cubit => widget._cubit;

  late final FocusNode toUniversityFN, cityFN, targetFN, vehicleFN, seatsFN, descriptionFN, dateFN, timeFN;

  @override
  void initState() {
    toUniversityFN = FocusNode();
    cityFN = FocusNode();
    targetFN = FocusNode();
    vehicleFN = FocusNode();
    seatsFN = FocusNode();
    descriptionFN = FocusNode();
    dateFN = FocusNode();
    timeFN = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    toUniversityFN.dispose();
    cityFN.dispose();
    targetFN.dispose();
    vehicleFN.dispose();
    seatsFN.dispose();
    descriptionFN.dispose();
    dateFN.dispose();
    timeFN.dispose();
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
                const Text("¿Vas para la U?", style: TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.smallTextFontSize)),
                cupertino.CupertinoSwitch(
                  focusNode: toUniversityFN,
                  value: newTripState.toU,
                  activeColor: MyColors.purpleTheme,
                  onChanged: cubit.updateToU
                )
              ],
            ),
            //CIUDAD
            SelectionFormField(
              onChanged: (s) {
                cubit.updateCity(Cities.fromString(s));
                targetFN.requestFocus();
              },
              currentValue: newTripState.newTripModel.city.nameFormat,
              focusNode: cityFN,
              fieldType: FieldTypes.cities,
              validator: newTripState.cityValidator,
              selectionFieldType: SelectionFieldTypes.cities,
              autovalidateMode: newTripState.autoValidateMode,
            ),
            //DIRECCIÓN
            OrdinaryFormField(
              onChanged: cubit.updateTarget,
              validator: newTripState.targetValidator,
              currentValue: newTripState.newTripModel.target,
              focusNode: targetFN,
              nextFocusNode: vehicleFN,
              fieldType: FieldTypes.target,
              autovalidateMode: newTripState.autoValidateMode,
              textCapitalization: TextCapitalization.words,
              enabled: false,
            ),
            //VEHÍCULO
            OrdinaryFormField(
              onChanged: cubit.updateVehicle,
              validator: newTripState.vehicleValidator,
              currentValue: newTripState.newTripModel.vehicleId,
              focusNode: vehicleFN,
              nextFocusNode: seatsFN,
              fieldType: FieldTypes.vehicleBrand,
              autovalidateMode: newTripState.autoValidateMode,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //VEHÍCULO
                ListTile(),
                //ASIENTOS DISPONIBLES
                SpinBox(
                  focusNode: seatsFN,
                  min: 1,
                  max: 59,
                  step: 1,
                  value: 1,
                  textStyle: const TextStyle(color: MyColors.purpleTheme),
                  validator: newTripState.seatsValidator,
                  iconColor: const MaterialStatePropertyAll(MyColors.purpleTheme),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Núm. Asientos", hintText: "Ej. 6"),
                  direction: Axis.vertical,
                  onChanged: (s) {
                    cubit.updateSeats(s.toInt());
                    descriptionFN.requestFocus();
                  },
                ),
              ].map((e) => SizedBox(width: SizeConfig.displayWidth(context) * 0.35, child: e)).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //FECHA DE PARTIDA
                ListTile(),
                //HORA DE PARTIDA
                ListTile()
              ].map((e) => SizedBox(width: SizeConfig.displayWidth(context) * 0.35, child: e)).toList(),
            ),
            //DESCRIPCION
            OrdinaryFormField(
              onChanged: cubit.updateDescription,
              validator: newTripState.descriptionValidator,
              currentValue: newTripState.newTripModel.description,
              focusNode: descriptionFN,
              nextFocusNode: null,
              fieldType: FieldTypes.vehiclePlate,
              autovalidateMode: newTripState.autoValidateMode,
              maxLength: 6,
              textCapitalization: TextCapitalization.characters,
            ),
            FloatingActionButton.extended(
              onPressed: () async{
                cubit.updateSubmitted(true);
                if (formKey.currentState!.validate() && newTripState.isValid) {
                  AsyncProgressDialog.show(context);
                  final bool successful = await cubit.submit();
                  if(context.mounted){
                    if (successful) {
                      Navigator.pop<bool>(context, successful);
                      dispose();
                    } else {
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
}