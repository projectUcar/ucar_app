library form_screen;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import '../../components/already_have_an_account.dart';
import '../../components/app_bar_custom.dart';
import '../../config/size_config.dart';
import '../../models/vm/user_login_view_model.dart';
import '../../models/vm/user_signup_view_model.dart';
import '../../models/vm/user_view_model.dart';
import '../../theme/colors.dart';
import '../../theme/custom_styles.dart';
import '../../theme/fontsizes.dart';
import '../../widgets/forms/form_template.dart';
import '../background.dart';
part 'login.dart';
part 'sign_up.dart';
abstract class FormScreen<T extends UserViewModel> extends StatelessWidget {
  FormScreen({super.key, bool? withAppBar}): _withAppBar = withAppBar ?? false;

  final formKey = GlobalKey<FormState>();
  final bool _withAppBar;

  ValueNotifier<T> _usNotifier();

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _withAppBar ? const PreferredSize(
        child: AppBarCustom(
          color: MyColors.backgroundSvg,
          text: "",
        ),
        preferredSize: Size.fromHeight(50),
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
    );
  }

  @mustCallSuper
  ValueListenableBuilder<T> buildValueListenable() => ValueListenableBuilder<T>(
      valueListenable: _usNotifier(),
      builder: (context, viewModel, _) => _getForm(context, viewModel),
  );

  FormTemplate<T> _getForm( BuildContext context, T viewModel);

  List<Widget> _buildChildren(BuildContext context);
}