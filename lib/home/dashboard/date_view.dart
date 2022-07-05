import 'package:flutter/material.dart';
import '../Trip.dart';
import 'package:intl/intl.dart';
import 'budget_view.dart';

class NewTripDateView extends StatelessWidget {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  final Trip trip;
  NewTripDateView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Plan - Date'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Location ${trip.title}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      "Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}"),
                  Text(
                      "End Date: ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}"),
                ],
              ),
              RaisedButton(
                child: Text('Continue'),
                onPressed: () {
                  trip.startDate = _startDate;
                  trip.endDate = _endDate;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTripBudgetView(trip: trip)),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
