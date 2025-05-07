import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/assets.dart';
import 'package:alhadara_dashboard/core/utils/go_router_path.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:alhadara_dashboard/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:alhadara_dashboard/features/login/presentation/manager/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../core/widgets/text_icon_button.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess) {
          emailController.clear();
          passwordController.clear();
          context.go(GoRouterPath.dashboard);
        }
      },
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
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
                      Container(
                        width: 700.w,
                        height: 400.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.logo),
                          ),
                        ),
                      ),
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
                            CustomLabelTextFormField(
                              labelText: 'Password',
                              showLabelText: true,
                              controller: passwordController,
                              topPadding: 42.h,
                              bottomPadding: 0.h,
                              leftPadding: 175.w,
                              rightPadding: 127.w,
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: GestureDetector(
                                onTap: (){context.go(GoRouterPath.verification);},
                                child: Padding(
                                  padding: EdgeInsets.only(right: 127.w),
                                  child: Text(
                                    'Forget password?',
                                    style: Styles.l1Normal(color: AppColors.purple),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 100.h,),
                            TextIconButton(
                              textButton: 'Log in',
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
                                cubit.fetchCreateTrainer(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  fcm_token: 'fcmToken',
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
