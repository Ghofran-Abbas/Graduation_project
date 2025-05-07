import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/verification_cubit/verification_cubit.dart';
import '../../manager/verification_cubit/verification_state.dart';

class VerificationViewBody extends StatelessWidget {
  VerificationViewBody({super.key});

  final TextEditingController verificationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if(state is VerificationSuccess) {
            context.go(GoRouterPath.dashboard);
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
          return Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(height: 200.h,),
                Stack(
                  children: [
                    /*Container(
                    width: 200.w,
                    height: 200.h,
                    color: AppColors.purple,
                  ),*/
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Pinput(
                                length: 5,
                                defaultPinTheme: defaultPinTheme,
                                onCompleted: (pin) {
                                  log('Entered code: $pin');
                                  verificationController.text = pin;
                                },
                              ),
                              CustomLabelTextFormField(
                                labelText: 'Passwords',
                                showLabelText: true,
                                controller: passwordController,
                                topPadding: 20.h,
                                bottomPadding: 0.h,
                                leftPadding: 175.w,
                                rightPadding: 127.w,
                              ),
                              CustomLabelTextFormField(
                                labelText: 'Password confirmation',
                                showLabelText: true,
                                controller: passwordConfirmationController,
                                topPadding: 20.h,
                                bottomPadding: 0.h,
                                leftPadding: 175.w,
                                rightPadding: 127.w,
                              ),
                              SizedBox(height: 100.h,),
                              TextIconButton(
                                textButton: 'Verification',
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
                                  cubit.fetchVerification(
                                    token: verificationController.text,
                                    password: passwordController.text,
                                    password_confirmation: passwordConfirmationController.text,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    /*Container(
                    width: 200.w,
                    height: 200.h,
                    color: AppColors.purple,
                  ),*/
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}

