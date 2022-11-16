part of 'calendar_cubit.dart';

@immutable
class CalendarState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const CalendarState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoading});
}
