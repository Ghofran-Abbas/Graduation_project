import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarViewBody extends StatelessWidget {
  const CalendarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 6,
      dataSource: SectionDataSource(getAppointments()),
      timeSlotViewSettings: TimeSlotViewSettings(
        startHour: 0,
        endHour: 24,
        timeIntervalHeight: 80, // لزيادة وضوح الفواصل الزمنية
      ),

    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 5, 0, 0);
  final DateTime endTime =  startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Section 1',
    color: AppColors.purple,
    recurrenceRule: 'FREQ=DAILY;COUNT=10'

  ));

  return meetings;
}

class SectionDataSource extends CalendarDataSource {
  SectionDataSource(List<Appointment> source) {
    appointments = source;
  }
}
