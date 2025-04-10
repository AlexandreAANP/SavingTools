import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {

  Function onDateSelected;

  DatePicker({super.key, required this.onDateSelected});

  @override
  _DatePickerState createState() => _DatePickerState(onDateSelected: onDateSelected);
}

class _DatePickerState extends State<DatePicker> with RestorationMixin{

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  
  final Function onDateSelected;

  _DatePickerState({required this.onDateSelected});
  
  @override
  String? get restorationId => "addInvoice";

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      onDateSelected(newSelectedDate);
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  } 
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          
    );
  }
}