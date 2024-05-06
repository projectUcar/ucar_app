library form_template;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../components/form_fields/field_types.dart';
import '../../components/form_fields/selection_fields/selection_form_field.dart';
import '../../components/form_fields/text_fields/ordinary_form_field.dart';
import '../../components/form_fields/text_fields/password_form_field.dart';
import '../../config/size_config.dart';
import '../../routes/app_router.dart';
import '../../storage/auth_client.dart';
import '../../theme/themes.dart';
import '../../util/widget_list_format.dart';
import '../temporaries/async_progress_dialog.dart';
import '../temporaries/dio_alert_dialog.dart';
part 'login_form.dart';
part 'sign_up_form.dart';

abstract class FormTemplate<T extends UserState, U extends FormValidatorCubit> extends StatefulWidget with WidgetListFormatter{
  const FormTemplate({super.key, required this.formKey, required this.cubit, required this.text, required this.successRoute});

  final GlobalKey<FormState> formKey;
  final U cubit;
  final String text, successRoute;

  @override
  State<FormTemplate<T, U>> createState();
}

abstract class _FormTemplateState<X extends FormTemplate> extends State<X>{
  
  late FocusNode buttonFocusNode;
  final ValueNotifier<bool> _submitted = ValueNotifier<bool>(false);

  @override
  void initState() {
    buttonFocusNode = FocusNode();
    super.initState();
  }
  
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return BlocSelector<FormValidatorCubit, UserState, bool>(
      bloc: widget.cubit,
      selector: (state) => widget.cubit.rebuildCondition,
      builder: (context, currentlyValid) {
        return Form(
          key: widget.formKey,
          autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          child: ValueListenableBuilder<bool>(
            valueListenable: _submitted, 
            builder: (context, value, _) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.formatList(_finalList(context), SizeConfig.displayHeight(context) * 0.03)
            ),
          )
        );
      }
    );
  }

  @mustCallSuper
  Future<void> _onSubmit() async{
    _submitted.value = true;
    if (widget.formKey.currentState!.validate() && widget.cubit.state.isValid()) {
      AsyncProgressDialog.show(context);
      await widget.cubit.submit();
      if(context.mounted) AsyncProgressDialog.dismiss(context);
    }
  }

  @mustCallSuper
  List<Widget> _finalList(BuildContext context) {
    List<Widget> list = _buildChildren(context)..add(FloatingActionButton.extended(
      focusNode: buttonFocusNode,
      foregroundColor: MyColors.primary,
      backgroundColor: MyColors.purpleTheme,
      onPressed: () => _onSubmit().then<void>((_) {
        if (widget.cubit.state.isRejected) {DioAlertDialog.fromDioError(context, widget.cubit.state);}
        else if (widget.cubit.state.isAccepted) {redirect();}
      }),
      label: Text(widget.text, style: CustomStyles.boldStyle.copyWith(fontSize: 20))
    ));
    return list;
  }

  List<Widget> _buildChildren(BuildContext context);

  @override
  void dispose() {
    buttonFocusNode.dispose();
    super.dispose();
  }
  
  @mustCallSuper
  Future<void> redirect() => widget.cubit.close();
}