// import 'package:company_crm/store/models/current-day.model.dart';
// import 'package:company_crm/store/models/current-month.model.dart';
// import 'package:company_crm/store/models/filter.model.dart';
// import 'package:company_crm/store/models/holiday.model.dart';
// import 'package:company_crm/store/models/project.model.dart';
// import 'package:company_crm/store/models/timelog.model.dart';
// import 'package:company_crm/store/models/user.model.dart';
// import 'package:company_crm/store/models/vacation.model.dart';
// import 'package:company_crm/store/reducers/reducer.dart';
// import 'package:reselect/reselect.dart';

// final List<TimelogModel> Function(AppState) timeLogCalendarSelect =
//     (AppState state) => state.timelog;
// final List<VacationModel> Function(AppState) vacationAllCalendarSelect =
//     (AppState state) => state.vacationsAll;
// final List<VacationModel> Function(AppState) vacationCalendarSelect =
//     (AppState state) => state.vacations;
// final List<TimelogModel> Function(AppState) timeLogAllCalendarSelect =
//     (AppState state) => state.timelogAll;
// final List<ProjectModel> Function(AppState) projectsSelect =
//     (AppState state) => state.projects;
// final CurrentDateModel Function(AppState) currentDaySelect =
//     (AppState state) => state.currentDays;
// final CurrentMonthModel Function(AppState) currentMonthSelect =
//     (AppState state) => state.currentMonth;
// final List<UserModel> Function(AppState) usersSelect =
//     (AppState state) => state.users;
// final FilterModel Function(AppState) filterSelect =
//     (AppState state) => state.filter;
// final List<HolidayModel> Function(AppState) holidaysSelect =
//     (AppState state) => state.holidays;

// final int Function(AppState) workTimeMonthSelector =
//     createSelector3(holidaysSelect, currentMonthSelect, vacationCalendarSelect,
//         (List<HolidayModel> holidays, CurrentMonthModel currentMonth,
//             List<VacationModel> vacations) {
//   final List<HolidayModel> holidaysWithoutSatSun = holidays
//       .where((HolidayModel holiday) =>
//           DateTime(holiday.date.year, holiday.date.month) ==
//               DateTime(currentMonth.timelog.year, currentMonth.timelog.month) &&
//           holiday.date.weekday != 6 &&
//           holiday.date.weekday != 7)
//       .toList();
//   final int paidVacationCount = vacations
//           .where((VacationModel vacation) =>
//               vacation.type == 1 || vacation.type == 3)
//           .length *
//       8;
//   final int satSunCount =
//       sundays(currentMonth.timelog.year, currentMonth.timelog.month);
//   final int weekend = holidaysWithoutSatSun.length + satSunCount;
//   final DateTime lastDayOfMonth =
//       DateTime(currentMonth.timelog.year, currentMonth.timelog.month + 1, 0);
//   return (lastDayOfMonth.day - weekend) * 8 - paidVacationCount;
// });

// final int Function(AppState) workTimeMonthByUserSelector = createSelector4(
//     holidaysSelect, currentMonthSelect, vacationAllCalendarSelect, filterSelect,
//     (
//   List<HolidayModel> holidays,
//   CurrentMonthModel currentMonth,
//   List<VacationModel> vacations,
//   FilterModel filter,
// ) {
//   final List<HolidayModel> holidaysWithoutSatSun = holidays
//       .where((HolidayModel holiday) =>
//           DateTime(holiday.date.year, holiday.date.month) ==
//               DateTime(currentMonth.timelogAll.year,
//                   currentMonth.timelogAll.month) &&
//           holiday.date.weekday != 6 &&
//           holiday.date.weekday != 7)
//       .toList();
//   final int paidVacationCount = vacations.where((VacationModel vacation) {
//         if (vacation.userId == filter?.user?.userId) {
//           return vacation.type == 1 || vacation.type == 3;
//         }
//         return false;
//       }).length *
//       8;
//   final int satSunCount =
//       sundays(currentMonth.timelogAll.year, currentMonth.timelogAll.month);
//   final int weekend = holidaysWithoutSatSun.length + satSunCount;
//   final DateTime lastDayOfMonth = DateTime(
//       currentMonth.timelogAll.year, currentMonth.timelogAll.month + 1, 0);
//   return (lastDayOfMonth.day - weekend) * 8 - paidVacationCount;
// });

// int sundays(int year, int month) {
//   int day = 1;
//   int counter = 0;
//   DateTime date = DateTime(year, month, day);
//   while (date.month == month) {
//     if (date.weekday == 6 || date.weekday == 7) {
//       counter += 1;
//     }
//     day += 1;
//     date = DateTime(year, month, day);
//   }
//   return counter;
// }

// final List<TimelogModel> Function(AppState) currentDayTimelogSelector =
//     createSelector3(
//         timeLogCalendarSelect,
//         currentDaySelect,
//         projectsSelect,
//         (List<TimelogModel> timelog, CurrentDateModel currentDay,
//                 List<ProjectModel> projects) =>
//             timelog
//                 .map((TimelogModel timelog) {
//                   final ProjectModel projectModel =
//                       projects.firstWhere((ProjectModel project) {
//                     return project.projectId == timelog.projectId;
//                   }, orElse: () => null);
//                   return TimelogModel(
//                       id: timelog.id,
//                       projectId: timelog.projectId,
//                       date: timelog.date,
//                       userId: timelog.userId,
//                       desc: timelog.desc,
//                       projectName: projectModel.name,
//                       time: timelog.time);
//                 })
//                 .where((TimelogModel timelog) =>
//                     timelog.date == currentDay.timelog)
//                 .toList());

// final Map<DateTime, List<dynamic>> Function(AppState)
//     timeLogFilteredCalendarSelector = createSelector3(
//         timeLogCalendarSelect, projectsSelect, vacationCalendarSelect,
//         (List<TimelogModel> timelog, List<ProjectModel> projects,
//             List<VacationModel> vacations) {
//   final List<TimelogModel> timelogList = timelog.map((TimelogModel timelog) {
//     final ProjectModel projectModel =
//         projects.firstWhere((ProjectModel project) {
//       return project.projectId == timelog.projectId;
//     }, orElse: () => null);
//     return TimelogModel(
//         id: timelog.id,
//         projectId: timelog.projectId,
//         date: timelog.date,
//         userId: timelog.userId,
//         desc: timelog.desc,
//         projectName: projectModel.name,
//         time: timelog.time);
//   }).toList();
//   final List<VacationModel> vacationsList =
//       vacations.map((VacationModel vacation) {
//     return VacationModel(
//         type: vacation.type,
//         userId: vacation.userId,
//         desc: vacation.desc,
//         status: vacation.status,
//         date: vacation.date,
//         id: vacation.id);
//   }).toList();
//   final List<dynamic> timelogVacationList = <dynamic>[
//     ...vacationsList,
//     ...timelogList
//   ];
//   final List<DateTimelog> list = timelogVacationList.fold(<DateTimelog>[],
//       (List<DateTimelog> value, dynamic el) {
//     final List<DateTimelog> res =
//         value.where((DateTimelog data) => data.date == el.date).toList();
//     if (res.length == 0) {
//       value.add(DateTimelog(date: el.date as DateTime, timelog: <dynamic>[el]));
//       return value;
//     }
//     value = value.map((DateTimelog val) {
//       if (val.date == el.date) {
//         val.timelog.add(el);
//         return val;
//       }
//       return val;
//     }).toList();
//     return value;
//   });
//   return <DateTime, List<dynamic>>{
//     for (DateTimelog timelog in list) timelog.date: timelog.timelog
//   };
// });

// final List<TimelogModel> Function(AppState) currentDayAllSelector =
//     createSelector5(timeLogAllCalendarSelect, currentDaySelect, projectsSelect,
//         usersSelect, filterSelect, (List<TimelogModel> timelog,
//             CurrentDateModel currentDay,
//             List<ProjectModel> projects,
//             List<UserModel> users,
//             FilterModel filter) {
//   return timelog
//       .where((TimelogModel timelog) =>
//           filter?.user != null ? timelog.userId == filter.user.userId : true)
//       .where((TimelogModel timelog) => filter?.project != null
//           ? timelog.projectId == filter.project.projectId
//           : true)
//       .map((TimelogModel timelog) {
//         final ProjectModel projectModel =
//             projects.firstWhere((ProjectModel project) {
//           return project.projectId == timelog.projectId;
//         }, orElse: () => null);
//         final UserModel userModel = users.firstWhere((UserModel user) {
//           return user.userId == timelog.userId;
//         }, orElse: () => UserModel());
//         return TimelogModel(
//             id: timelog.id,
//             projectId: timelog.projectId,
//             date: timelog.date,
//             userId: timelog.userId,
//             desc: timelog.desc,
//             projectName: projectModel.name,
//             userAvatar: userModel.avatar,
//             time: timelog.time);
//       })
//       .where((TimelogModel timelog) => timelog.date == currentDay.timelogAll)
//       .toList();
// });

// final Map<DateTime, List<dynamic>> Function(AppState)
//     timeLogAllFilteredCalendarSelector = createSelector5(
//         timeLogAllCalendarSelect,
//         projectsSelect,
//         usersSelect,
//         filterSelect,
//         vacationAllCalendarSelect, (List<TimelogModel> timelog,
//             List<ProjectModel> projects,
//             List<UserModel> users,
//             FilterModel filter,
//             List<VacationModel> vacations) {
//   final List<TimelogModel> timelogList = timelog
//       .where((TimelogModel timelog) =>
//           filter?.user != null ? timelog.userId == filter.user.userId : true)
//       .where((TimelogModel timelog) => filter?.project != null
//           ? timelog.projectId == filter.project.projectId
//           : true)
//       .map((TimelogModel timelog) {
//     final ProjectModel projectModel =
//         projects.firstWhere((ProjectModel project) {
//       return project.projectId == timelog.projectId;
//     }, orElse: () => null);
//     final UserModel userModel = users.firstWhere((UserModel user) {
//       return user.userId == timelog.userId;
//     }, orElse: () => null);
//     return TimelogModel(
//         id: timelog.id,
//         projectId: timelog.projectId,
//         date: timelog.date,
//         userId: timelog.userId,
//         desc: timelog.desc,
//         projectName: projectModel.name,
//         userAvatar: userModel.avatar,
//         time: timelog.time);
//   }).toList();
//   final List<VacationModel> vacationsList = vacations
//       .map((VacationModel vacation) {
//         return VacationModel(
//             type: vacation.type,
//             userId: vacation.userId,
//             desc: vacation.desc,
//             status: vacation.status,
//             date: vacation.date,
//             id: vacation.id);
//       })
//       .where((VacationModel vacation) =>
//           filter?.user != null ? filter.user.userId == vacation.userId : false)
//       .toList();
//   final List<dynamic> timelogVacationList = <dynamic>[
//     ...vacationsList,
//     ...timelogList
//   ];

//   final List<DateTimelog> list = timelogVacationList.fold(<DateTimelog>[],
//       (List<DateTimelog> value, dynamic el) {
//     final List<DateTimelog> res =
//         value.where((DateTimelog data) => data.date == el.date).toList();
//     if (res.length == 0) {
//       value.add(DateTimelog(date: el.date as DateTime, timelog: <dynamic>[el]));
//       return value;
//     }
//     value = value.map((DateTimelog val) {
//       if (val.date == el.date) {
//         val.timelog.add(el);
//         return val;
//       }
//       return val;
//     }).toList();
//     return value;
//   });
//   return <DateTime, List<dynamic>>{
//     for (DateTimelog timelog in list) timelog.date: timelog.timelog
//   };
// });

// class DateTimelog {
//   DateTimelog({this.date, this.timelog});
//   DateTime date;
//   List<dynamic> timelog;
// }
