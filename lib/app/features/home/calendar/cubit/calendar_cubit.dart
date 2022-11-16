import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(const CalendarState(
          //super contains starting values of parameters
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const CalendarState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('categories')
        .orderBy('time', descending: false)
        .snapshots()
        .listen((data) {
      emit(
        CalendarState(documents: data.docs, errorMessage: '', isLoading: false),
      );
    })
      ..onError((error) {
        emit(
          CalendarState(
            documents: [],
            errorMessage: error.toString(),
            isLoading: true,
          ),
        );
      });

//await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
