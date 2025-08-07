import 'dart:developer';

import 'package:alhadara_dashboard/features/profile/presentaion/views/widgets/profile_view_body.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/data/repos/department_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/presentation/manager/departments_cubit/departments_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/logout/data/repos/logout_secretary_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/logout/presentation/manager/logout_secretary_cubit/logout_secretary_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/localization/app_localizations_setup.dart';
import 'core/localization/local_cubit/local_cubit.dart';
import 'core/utils/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'features/login/data/repos/login_secretary_repo_impl.dart';
import 'features/login/presentation/manager/login_cubit/login_secretary_cubit.dart';
import 'features/secretary_features/student/presentation/manager/students_cubit/students_cubit.dart';
import 'firebase_options.dart';

// لكل الرسائل الواردة في الخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // هنا يمكنك التعامل مع payload أو عرض إشعار محلي
  print('Background message: ${message.messageId}');
}


void main() async {

  setupServiceLocator();
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging _messaging;
  String? _token;

  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
  }

  void _initFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // طلب الإذن للإشعارات (للويب يظهر حوار المتصفح)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // الحصول على الـ FCM token (ستستخدمه في السيرفر لإرسال الإشعارات)
      _token = await _messaging.getToken(
          vapidKey: 'BMUIu0ik_OZJ9r9n3GPXib5fouwP02aKUqHBPJZFio406nmC_henlk7OtEco9fc5xd7Q3q_tZM0RuP6oBBPqTPc'
      );
      print('FCM Token: $_token');

      // استقبال الرسائل أثناء فتح التطبيق (foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null) {
          // هنا يمكنك عرض حوار أو إشعار محلي باستخدام flutter_local_notifications
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(notification.title ?? ''),
              content: Text(notification.body ?? ''),
            ),
          );
        }
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
        BlocProvider(
          create: (context) {
            return LoginCubit(
              getIt.get<LoginRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UserCubit(
              //getIt.get<LoginRepoImpl>(),
            )..loadUser();
          },
        ),
        BlocProvider(
          create: (context) {
            return LogoutSecretaryCubit(
              getIt.get<LogoutSecretaryRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DepartmentsCubit(
              getIt.get<DepartmentRepoImpl>(),
            )..fetchDepartments(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return StudentsCubit(
              getIt.get<StudentRepoImpl>(),
            )..fetchStudents(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return TrainersCubit(
              getIt.get<TrainerRepoImpl>(),
            )..fetchTrainers(page: 1);
          },
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(1440, 1024),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationParser: AppRouter.router.routeInformationParser,
                routeInformationProvider: AppRouter.router.routeInformationProvider,
                debugShowCheckedModeBanner: false,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
                locale: locale,
              );
            },
          );
        },
      ),
    );
  }
}