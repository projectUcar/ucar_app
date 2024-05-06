library form_screen;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import '../../util/widget_list_format.dart';
import '../../components/already_have_an_account.dart';
import '../../components/app_bar_custom.dart';
import '../../theme/themes.dart';
import '../../widgets/forms/form_template.dart';
import '../wrappers/background.dart';
part 'login.dart';
part 'sign_up.dart';
abstract class FormScreen<T extends UserState, U extends FormValidatorCubit> extends StatelessWidget {
  FormScreen({super.key, bool? withAppBar, required ValueNotifier<T> usNotifier}): _withAppBar = withAppBar ?? false, _usNotifier = usNotifier;

  final formKey = GlobalKey<FormState>();
  final bool _withAppBar;

  final ValueNotifier<T> _usNotifier;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(formKey.currentContext ?? context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: _withAppBar ? const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarCustom(
            color: MyColors.backgroundSvg,
            text: "",
          ),
        ): null,
        body: Background(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren(context),
            ),
          ),
        ),
      ),
    );
  }

  @mustCallSuper
  ValueListenableBuilder<T> buildValueListenable(BuildContext context) => ValueListenableBuilder<T>(
    valueListenable: _usNotifier,
    builder: (context, userState, _) => _getForm(context, userState),
  );

  FormTemplate<T, U> _getForm(BuildContext context, T userState);

  List<Widget> _buildChildren(BuildContext context);
}