import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_planner/app/home/calendar/cubit/calendar_cubit.dart';
import 'package:my_planner/app/widgets/category_widget.dart';

class CalendarPageContent extends StatelessWidget {
  const CalendarPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => CalendarCubit()..start(),
          child: BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, state) {
              state.documents;
              if (state.errorMessage.isNotEmpty) {
                return Text("Error: ${state.errorMessage}");
              }
              if (state.isLoading) {
                //equivalent of state.isLoading == true
                return const Center(child: CircularProgressIndicator());
              }

              final documents = state.documents;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final document in documents) ...[
                      Dismissible(
                        key: ValueKey(document.id),
                        onDismissed: (_) {
                          FirebaseFirestore.instance
                              .collection('categories')
                              .doc(document.id)
                              .delete();
                        },
                        child: Row(
                          children: [
                            CategoryWidget(
                              document['title'],
                            ),
                            CategoryWidget(
                              document['time'].toString(),
                            ),
                            //CategoryWidget(
                            //  document['priority'].toString(),
                            //),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}
