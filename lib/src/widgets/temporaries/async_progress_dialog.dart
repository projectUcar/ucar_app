import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucar_app/src/config/size_config.dart';
import 'package:ucar_app/src/theme/themes.dart';

abstract class AsyncProgressDialog{
  static show(BuildContext context){
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Container(
            width: SizeConfig.displayWidth(context),
            height: SizeConfig.displayHeight(context),
            color: MyColors.primary.withOpacity(0.9),
            child: const Center(child: CircularProgressIndicator(color: MyColors.purpleTheme,),),
          ),
        );
      },
    );
  }

  static dismiss(BuildContext context)=> Navigator.pop(context);
}