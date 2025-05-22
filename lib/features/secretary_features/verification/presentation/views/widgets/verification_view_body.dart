import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/verification_cubit/verification_cubit.dart';
import '../../manager/verification_cubit/verification_state.dart';

class VerificationViewBody extends StatelessWidget {
  VerificationViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController verificationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if(state is VerificationSuccess) {
            context.go(GoRouterPath.login);
            CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('VerificationSuccess'),);
          } else if(state is VerificationFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('VerificationFailure'),);
          }
        },
        builder: (context, state) {
          VerificationCubit cubit = BlocProvider.of(context);
          final defaultPinTheme = PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
          );
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
                  SizedBox(height: 5.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Pinput(
                              length: 5,
                              defaultPinTheme: defaultPinTheme,
                              onCompleted: (pin) {
                                verificationController.text = pin;
                              },
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                            ),
                            CustomLabelTextFormField(
                              labelText: AppLocalizations.of(context).translate('Password'),
                              showLabelText: true,
                              controller: passwordController,
                              topPadding: 38.h,
                              bottomPadding: 0.h,
                              leftPadding: 375.w,
                              rightPadding: 327.w,
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                            ),
                            CustomLabelTextFormField(
                              labelText: AppLocalizations.of(context).translate('Password confirmation'),
                              showLabelText: true,
                              controller: passwordConfirmationController,
                              topPadding: 48.h,
                              bottomPadding: 0.h,
                              leftPadding: 375.w,
                              rightPadding: 327.w,
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                            ),
                            SizedBox(height: 100.h,),
                            TextIconButton(
                              textButton: AppLocalizations.of(context).translate('Verification'),
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
                                  cubit.fetchVerification(
                                  token: verificationController.text,
                                  password: passwordController.text,
                                  password_confirmation: passwordConfirmationController.text,
                                );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h,),
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

