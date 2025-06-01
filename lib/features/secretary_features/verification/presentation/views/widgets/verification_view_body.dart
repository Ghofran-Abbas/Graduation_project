import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/verification_cubit/verification_cubit.dart';
import '../../manager/verification_cubit/verification_state.dart';

class VerificationViewBody extends StatelessWidget {
  VerificationViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if(state is VerificationSuccess) {
            context.go(GoRouterPath.login);
            //CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('VerificationSuccess'),);
          } else if(state is VerificationFailure) {
            //CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('VerificationFailure'),);
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
                  SizedBox(height: 45.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'You should verification your account first',
                              style: Styles.h2Bold(),
                            ),
                            SizedBox(height: 120.h,),
                            Pinput(
                              length: 5,
                              defaultPinTheme: defaultPinTheme,
                              onCompleted: (pin) {
                                verificationController.text = pin;
                              },
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
                                //if(_formKey.currentState!.validate()) {
                                  cubit.fetchVerification(
                                    token: verificationController.text,
                                  );
                                //}
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 44.h,),
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
