import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../course/data/models/details_section_model.dart';
import '../../../../course/presentation/manager/details_section_cubit/details_section_cubit.dart';
import '../../../../course/presentation/manager/details_section_cubit/details_section_state.dart';

class InPreparationCalendarViewBody extends StatelessWidget {
  const InPreparationCalendarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsSectionCubit, DetailsSectionState>(
        listener: (context, state) {
          if (state is DetailsSectionFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DetailsSectionFailure'),);
          }
        },
        builder: (context, state) {
          if(state is DetailsSectionSuccess) {
            final appointments = generateSectionAppointments(state.section.section);
            return SfCalendar(
              view: CalendarView.week,
              firstDayOfWeek: 6,
              dataSource: SectionDataSource(appointments),
              timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 0,
                endHour: 24,
                timeIntervalHeight: 80,
              ),
            );
          } else if(state is DetailsSectionFailure) {
            List<Appointment> meetings = <Appointment>[];
            return SfCalendar(
              view: CalendarView.week,
              firstDayOfWeek: 6,
              dataSource: SectionDataSource(meetings),
              timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 0,
                endHour: 24,
                timeIntervalHeight: 80, // لزيادة وضوح الفواصل الزمنية
              ),
            );
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}

List<Appointment> generateSectionAppointments(Section section) {
  final List<Appointment> appointments = [];

  final startDate = section.startDate;
  final endDate = section.endDate;

  // خريطة تحويل اسم اليوم إلى رقم حسب DateTime
  final Map<String, int> weekDayToInt = {
    'monday': DateTime.monday,
    'tuesday': DateTime.tuesday,
    'wednesday': DateTime.wednesday,
    'thursday': DateTime.thursday,
    'friday': DateTime.friday,
    'saturday': DateTime.saturday,
    'sunday': DateTime.sunday,
  };

  for (final day in section.weekDays) {
    final dayNumber = weekDayToInt[day.name.toLowerCase()] ?? DateTime.monday;

    // نبدأ من تاريخ البداية ونمشي يومًا بيوم حتى نصل لنهاية الفترة
    DateTime current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (current.weekday == dayNumber) {
        final startParts = day.startTime.split(':').map(int.parse).toList();
        final endParts = day.endTime.split(':').map(int.parse).toList();

        final DateTime startTime = DateTime(
          current.year,
          current.month,
          current.day,
          startParts[0],
          startParts[1],
        );
        final DateTime endTime = DateTime(
          current.year,
          current.month,
          current.day,
          endParts[0],
          endParts[1],
        );

        appointments.add(
          Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: section.name,
            color: AppColors.purple,
          ),
        );
      }

      current = current.add(const Duration(days: 1));
    }
  }

  return appointments;
}

class SectionDataSource extends CalendarDataSource {
  SectionDataSource(List<Appointment> source) {
    appointments = source;
  }
}
