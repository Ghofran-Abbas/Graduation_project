import 'package:go_router/go_router.dart';

import '../../features/login/presentation/views/login_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_calendar_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_details_view.dart';
import '../../features/secretary_features/complete_course/presentation/views/complete_view.dart';
import '../../features/secretary_features/course/presentation/views/calendar_view.dart';
import '../../features/secretary_features/course/presentation/views/course_details_view.dart';
import '../../features/secretary_features/course/presentation/views/courses_view.dart';
import '../../features/secretary_features/department/presentation/views/departments_view.dart';
import '../../features/secretary_features/forgot_password/presentation/views/forgot_password_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_details_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_calendar_view.dart';
import '../../features/secretary_features/in_preparation_course/presentation/views/in_preparation_view.dart';
import '../../features/secretary_features/report/presentation/views/reports_view.dart';
import '../../features/secretary_features/student/presentation/views/student_details_view.dart';
import '../../features/secretary_features/trainer/presentation/views/trainer_details_view.dart';
import '../../features/secretary_features/trainer/presentation/views/trainers_view.dart';
import '../../features/secretary_features/verification/presentation/views/verification_view.dart';
import '../widgets/secretary/main_scaffold.dart';
import '../../features/secretary_features/student/presentation/views/students_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
        routes: [
          ShellRoute(
            builder: (context, state, child) => MainScaffold(child: child,),
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DepartmentsView(),
                routes: [
                  GoRoute(
                      path: '/courses/:id',
                      builder: (context, state) {
                        final id = state.pathParameters['id']!;
                        return CoursesView(id: int.parse(id),);
                      },
                      routes: [
                        GoRoute(
                            path: '/details',
                            builder: (context, state) {
                              return CourseDetailsView();
                            },
                            routes: [
                              GoRoute(
                                path: '/calendar',
                                builder: (context, state) {
                                  return CalendarView();
                                },
                              ),
                            ]
                        ),
                      ]
                  ),
                ]
              ),

              GoRoute(
                path: '/students',
                builder: (context, state) => const StudentsView(),
                routes: [
                  GoRoute(
                    path: '/studentDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return StudentDetailsView(id: int.parse(id),);
                    },
                  ),
                ]
              ),

              GoRoute(
                path: '/trainers',
                builder: (context, state) => const TrainersView(),
                routes: [
                  GoRoute(
                    path: '/trainerDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return TrainerDetailsView(id: int.parse(id),);
                    },
                  ),
                ]
              ),

              GoRoute(
                path: '/complete',
                builder: (context, state) => const CompleteView(),
                routes: [
                  GoRoute(
                    path: '/completeDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return CompleteDetailsView(id: int.parse(id),);
                    },
                    routes: [
                      GoRoute(
                        path: '/completeCalendar',
                        builder: (context, state) {
                          return CompleteCalendarView();
                        },
                      ),
                    ]
                  ),
                ]
              ),

              GoRoute(
                path: '/inPreparation',
                builder: (context, state) => const InPreparationView(),
                routes: [
                  GoRoute(
                    path: '/inPreparationDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return DetailsInPreparationView(id: int.parse(id),);
                    },
                    routes: [
                      GoRoute(
                        path: '/inPreparationCalendar',
                        builder: (context, state) {
                          return InPreparationCalendarView();
                        },
                      ),
                    ]
                  ),
                ]
              ),

              GoRoute(
                path: '/reports',
                builder: (context, state) => const ReportsView(),
                /*routes: [
                  GoRoute(
                    path: '/trainerDetails/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return TrainerDetailsView(id: int.parse(id),);
                    },
                  ),
                ]*/
              ),
            ]
          )
        ]
      ),
      GoRoute(
        path: '/verification',
        builder: (context, state) => const ForgotPasswordView(),
        routes: [
          GoRoute(
            path: '/passwordReset',
            builder: (context, state) => const VerificationView(),
          ),
        ]
      ),
    ],
  );
}
