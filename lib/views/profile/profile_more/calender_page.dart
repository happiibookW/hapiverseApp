import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../data/model/event.dart';
import '../../../logic/business_product/business_product_cubit.dart';
class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {

   var dateNow = DateTime.now();
   DateTime? selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
        builder: (context, businessToolState) {
           return Scaffold(
             appBar: AppBar(
               leading: IconButton(
                 icon: Icon(Icons.arrow_back, color: Colors.white),
                 onPressed: () {
                    Navigator.pop(context);
                 },
               ),
               title: Text("Calender",style: TextStyle(color: Colors.white),),
             ),
             body: Column(
               children: [
                 Card(
                   child: TableCalendar(

                     calendarBuilders: const CalendarBuilders(),
                     weekNumbersVisible: false,
                     focusedDay: DateTime.now(),
                     lastDay: DateTime(2050,12,2),
                     firstDay: DateTime(1965,12,2),
                     calendarStyle: const CalendarStyle(),
                     headerStyle: HeaderStyle(
                         formatButtonDecoration: BoxDecoration(
                           color: Colors.brown,
                           borderRadius: BorderRadius.circular(22.0),
                         ),
                         titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: ''),
                         formatButtonTextStyle: TextStyle(color: Colors.white),
                         formatButtonShowsNext: false,
                         formatButtonVisible: false,
                         titleCentered: true
                     ),
                     daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(fontWeight: FontWeight.bold),weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
                     startingDayOfWeek: StartingDayOfWeek.monday,
                     onDaySelected: (date, events) {
                       setState(() {
                         selectedDate = date;
                       });
                     },
                     eventLoader: (date) {
                       // Filter events based on the selected date
                       final bloc2 = context.read<BusinessProductCubit>();
                       return bloc2.state.businessEvent?.where((event) =>
                       event.eventDate?.year == date.year &&
                           event.eventDate?.month == date.month &&
                           event.eventDate?.day == date.day).toList() ?? [];
                     },
                   ),
                 ),
                 if (selectedDate != null &&
                     businessToolState.businessEvent != null &&
                     businessToolState.businessEvent!.isNotEmpty)
                   Expanded(
                     child: ListView.builder(
                       itemCount: businessToolState.businessEvent!.length,
                       itemBuilder: (context, index) {
                         final event = businessToolState.businessEvent![index];
                         if (event.eventDate != null &&
                             event.eventDate!.year == selectedDate!.year &&
                             event.eventDate!.month == selectedDate!.month &&
                             event.eventDate!.day == selectedDate!.day) {
                           return ListTile(
                             title:  Text(DateFormat.yMMMd().format(event.eventDate!)),
                             subtitle: Text("${event.eventName} at ${event.eventTime }"?? ''),
                           );
                         } else {
                           return const SizedBox.shrink();
                         }
                       },
                     ),
                   ),
               ],
             ),
           );
        });

  }
}
