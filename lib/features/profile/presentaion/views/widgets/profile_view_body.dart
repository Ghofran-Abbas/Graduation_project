import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../login/data/models/login_secretary_model.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 56.0.h),
          child: CustomScreenBody(
            title: state is UserLoaded ? state.user.name : '...',
            showProfileAvatar: false,
            onPressedFirst: () {},
            onPressedSecond: () {},
            onTapSearch: () {},
            body: Padding(
              padding: EdgeInsets.only(
                top: 238.0.h,
                left: 20.0.w,
                right: 20.0.w,
                bottom: 27.0.h,
              ),
              child: _buildBody(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(UserState state) {
    if (state is UserLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is UserError) {
      return Center(child: Text(state.message));
    } else if (state is UserLoaded) {
      final user = state.user;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProfileInformation(
              image: user.photo, // تأكد من أنه URL صحيح
              name: user.name,
              detailsText: 'Secretary',
              showDetailsText: true,
              firstBoxText: user.phone,
              firstBoxIcon: Icons.phone_in_talk_outlined,
              secondBoxText: user.email,
              secondBoxIcon: Icons.mail_outlined,
              firstFieldInfoText: user.birthday,
              secondFieldInfoText: user.gender,
              onTap: () {}, labelText: '', tailText: '', avatarCount: 1,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loadUser() async {
    emit(UserLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('login_model');
      if (userJson != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(userJson);
        final model = LoginSecretaryModel.fromJson(jsonMap);
        emit(UserLoaded(model.accessToken.user));
      } else {
        emit(UserError('No saved user'));
      }
    } catch (e) {
      emit(UserError('Error loading user: $e'));
    }
  }
}

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}
