import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../manager/forgot_password_cubit/forgot_password_state.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  ForgotPasswordViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if(state is ForgotPasswordSuccess) {
            context.go(GoRouterPath.passwordReset);
          }
        },
        builder: (context, state) {
          ForgotPasswordCubit cubit = BlocProvider.of(context);
          return Form(
            key: _formKey,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      width: 300.w,
                      height: 260.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(130.r)),
                        color: AppColors.purple,
                      ),
                    ),
                  ),
                  SizedBox(height: 121.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CustomLabelTextFormField(
                              labelText: AppLocalizations.of(context).translate('Email address'),
                              showLabelText: true,
                              controller: emailController,
                              topPadding: 20.h,
                              bottomPadding: 0.h,
                              leftPadding: 375.w,
                              rightPadding: 327.w,
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                            ),
                            SizedBox(height: 100.h,),
                            TextIconButton(
                              textButton: AppLocalizations.of(context).translate('Submit'),
                              bigText: true,
                              textColor: AppColors.white,
                              showButtonIcon: false,
                              iconLast: false,
                              firstSpaceBetween: 3.w,
                              buttonHeight: 53.h,
                              borderWidth: 0.w,
                              buttonColor: AppColors.purple,
                              borderColor: Colors.transparent,
                              onPressed: (){
                                if(_formKey.currentState!.validate()) {
                                  cubit.fetchForgotPassword(email: emailController.text,);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 121.h,),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      width: 300.w,
                      height: 260.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(130.r)),
                        color: AppColors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

