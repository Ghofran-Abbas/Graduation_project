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
import '../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../manager/forgot_password_cubit/forgot_password_state.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  ForgotPasswordViewBody({super.key});

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
                              CustomLabelTextFormField(
                                labelText: 'Email address',
                                showLabelText: true,
                                controller: emailController,
                                topPadding: 20.h,
                                bottomPadding: 0.h,
                                leftPadding: 175.w,
                                rightPadding: 127.w,
                              ),
                              SizedBox(height: 100.h,),
                              TextIconButton(
                                textButton: 'Submit',
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
                                  cubit.fetchForgotPassword(
                                    email: emailController.text,
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

