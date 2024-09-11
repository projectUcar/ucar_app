import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:ucar_app/src/config/size_config.dart';
import '../../blocs/blocs.dart';
import '../../components/form_fields/field_types.dart';
import '../../components/form_fields/selection_fields/selection_form_field.dart';
import '../../components/form_fields/text_fields/ordinary_form_field.dart';
import '../../theme/themes.dart';
import '../../util/options/document_types.dart';
import '../temporaries/async_progress_dialog.dart';

class DriverRequestForm extends StatefulWidget {
  const DriverRequestForm({super.key, required DriverCubit cubit}): _cubit = cubit;
  final DriverCubit _cubit;

  @override
  State<DriverRequestForm> createState() => _DriverRequestFormState();
}

class _DriverRequestFormState extends State<DriverRequestForm> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "DriverFormKEY");
  DriverCubit get cubit => widget._cubit;
  late final FocusNode isOwnerFN, docTypeFN, docNumFN, brandFN, modelFN, lineFN, plateFN, colorFN, seatsFN, doorsFN, ownerDocTypeFN, ownerDocNumberFN;

  @override
  void initState() {
    isOwnerFN = FocusNode();
    docTypeFN = FocusNode();
    docNumFN = FocusNode();
    brandFN = FocusNode();
    modelFN = FocusNode();
    lineFN = FocusNode();
    plateFN = FocusNode();
    colorFN = FocusNode();
    seatsFN = FocusNode();
    doorsFN = FocusNode();
    ownerDocTypeFN = FocusNode();
    ownerDocNumberFN = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    isOwnerFN.dispose();
    docTypeFN.dispose();
    docNumFN.dispose();
    brandFN.dispose();
    modelFN.dispose();
    lineFN.dispose();
    plateFN.dispose();
    colorFN.dispose();
    seatsFN.dispose();
    doorsFN.dispose();
    ownerDocTypeFN.dispose();
    ownerDocNumberFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverCubit, DriverState>(
      bloc: cubit,
      builder: (context, driverState) => Form(
        key: formKey,
        autovalidateMode: driverState.autoValidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("¿Eres el propietario del vehículo?", style: TextStyle(color: MyColors.textOrange, fontSize: Fontsizes.bodyTextFontSize + 2)),
                cupertino.CupertinoSwitch(
                  focusNode: isOwnerFN,
                  value: driverState.vehicle.isOwner,
                  activeColor: MyColors.purpleTheme,
                  onChanged: cubit.updateIsOwner
                )
              ],
            ),
            //CONDUCTOR
            SelectionFormField(
              onChanged: (s) {
                if (driverState.vehicle.isOwner == true) {
                  cubit.updateTypes(s);
                }else{
                  cubit.updateDocumentType(s);
                }
                docNumFN.requestFocus();
              },
              currentValue: driverState.documentType,
              focusNode: docTypeFN,
              fieldType: FieldTypes.docType,
              validator: driverState.docTypeValidator,
              selectionFieldType: SelectionFieldTypes.docTypes,
              autovalidateMode: driverState.autoValidateMode,
            ),
            OrdinaryFormField(
              onChanged: (driverState.vehicle.isOwner == true) ? cubit.updateValues : cubit.updateDocValue,
              validator: driverState.docNumberValidator,
              currentValue: driverState.docValue,
              focusNode: docNumFN,
              nextFocusNode: brandFN,
              fieldType: FieldTypes.docNumber,
              maxLength: driverState.documentType == DocumentTypes.nit.name ? 15 : 13,
              autovalidateMode: driverState.autoValidateMode,
            ),
            //VEHÍCULO
            OrdinaryFormField(
              onChanged: cubit.updateBrand,
              validator: driverState.brandValidator,
              currentValue: driverState.vehicle.brand,
              focusNode: brandFN,
              nextFocusNode: lineFN,
              fieldType: FieldTypes.vehicleBrand,
              autovalidateMode: driverState.autoValidateMode,
              textCapitalization: TextCapitalization.words,
            ),
            OrdinaryFormField(
              onChanged: cubit.updateLine,
              validator: driverState.lineValidator,
              currentValue: driverState.vehicle.line,
              focusNode: lineFN,
              nextFocusNode: modelFN,
              fieldType: FieldTypes.vehicleLine,
              autovalidateMode: driverState.autoValidateMode,
              textCapitalization: TextCapitalization.words,
            ),
            OrdinaryFormField(
              onChanged: cubit.updateModel,
              validator: driverState.modelValidator,
              currentValue: driverState.vehicle.model,
              focusNode: modelFN,
              nextFocusNode: plateFN,
              fieldType: FieldTypes.vehicleModel,
              autovalidateMode: driverState.autoValidateMode,
              maxLength: 4,
            ),
            OrdinaryFormField(
              onChanged: cubit.updatePlate,
              validator: driverState.plateValidator,
              currentValue: driverState.vehicle.plate,
              focusNode: plateFN,
              nextFocusNode: colorFN,
              fieldType: FieldTypes.vehiclePlate,
              autovalidateMode: driverState.autoValidateMode,
              maxLength: 6,
              textCapitalization: TextCapitalization.characters,
            ),
            OrdinaryFormField(
              onChanged: cubit.updateColor,
              validator: driverState.colorValidator,
              currentValue: driverState.vehicle.color,
              focusNode: colorFN,
              nextFocusNode: seatsFN,
              fieldType: FieldTypes.vehicleColor,
              autovalidateMode: driverState.autoValidateMode,
              textCapitalization: TextCapitalization.words,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.displayWidth(context) * 0.35,
                  child: SpinBox(
                    focusNode: seatsFN,
                    min: 1,
                    max: 59,
                    step: 1,
                    value: 1,
                    textStyle: const TextStyle(color: MyColors.purpleTheme),
                    validator: driverState.seatsValidator,
                    iconColor: const MaterialStatePropertyAll(MyColors.purpleTheme),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Núm. Asientos", hintText: "Ej. 6"),
                    direction: Axis.vertical,
                    onChanged: (s) {
                      cubit.updateSeats(s.toInt());
                      doorsFN.requestFocus();
                    },
                  ),
                ),
                SizedBox(
                  width: SizeConfig.displayWidth(context) * 0.35,
                  child: SpinBox(
                    focusNode: doorsFN,
                    min: 1,
                    max: 8,
                    step: 1,
                    value: 1,
                    textStyle: const TextStyle(color: MyColors.purpleTheme),
                    validator: driverState.doorsValidator,
                    iconColor: const MaterialStatePropertyAll(MyColors.purpleTheme),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Núm. Puertas", hintText: "Ej. 4"),
                    direction: Axis.vertical,
                    onChanged: (s) {
                      cubit.updateDoors(s.toInt());
                      if (!driverState.vehicle.isOwner) {
                        ownerDocTypeFN.requestFocus();
                      }
                    },
                  ),
                ),
              ],
            ),
            //PROPIETARIO
            Visibility(
              visible: !driverState.vehicle.isOwner,
              child: SelectionFormField(
                onChanged: (s) {
                  cubit.updateDocumentTypeOwner(s);
                  ownerDocNumberFN.requestFocus();
                },
                currentValue: driverState.vehicle.documentTypeOwner,
                focusNode: ownerDocTypeFN,
                fieldType: FieldTypes.docType,
                validator: driverState.docTypeValidator,
                selectionFieldType: SelectionFieldTypes.docTypes,
                autovalidateMode: driverState.autoValidateMode,
              ),
            ),
            Visibility(
              visible: !driverState.vehicle.isOwner,
              child: OrdinaryFormField(
                onChanged: cubit.updateDocumentNumberOwner,
                validator: driverState.docNumberValidator,
                currentValue: context.watch<DriverCubit>().state.vehicle.documentNumberOwner,
                focusNode: ownerDocNumberFN,
                nextFocusNode: null,
                fieldType: FieldTypes.docNumber,
                maxLength: driverState.vehicle.documentTypeOwner == DocumentTypes.nit.name ? 15 : 13,
                autovalidateMode: driverState.autoValidateMode,
              ),
            ),
            FloatingActionButton.extended(
              onPressed: () async{
                cubit.updateSubmitted(true);
                if (formKey.currentState!.validate() && driverState.isValid) {
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
}
