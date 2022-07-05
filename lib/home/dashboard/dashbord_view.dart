

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Trip.dart';
import './location_view.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class DashbordView extends StatelessWidget {
  List<Trip> tripsList = [
    Trip("Hyderabad", DateTime.now(), DateTime.now(), 30000.0, "Train"),
    Trip("Goa", DateTime.now(), DateTime.now(), 20000.0, "Train"),
    Trip("Chikmangluru", DateTime.now(), DateTime.now(), 15000.0, "Car"),
    Trip("Delhi", DateTime.now(), DateTime.now(), 25000.0, "Flight"),
    Trip("Chennai", DateTime.now(), DateTime.now(), 20000.0, "Flight"),
  ];
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final newTrip = Trip(" ", DateTime.now(), DateTime.now(), 00.00, " ");

    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        backgroundColor: Color.fromARGB(255, 72, 38, 115),
        elevation: 0.0,
        title: Text(
          'Plans',
          style: TextStyle(
              color: Color.fromARGB(255, 246, 235, 244), fontSize: 25),
        ),
      ),
      body: Snap(
        controller: controller.appBar,
        child: new ListView.builder(
            controller: controller,
            itemCount: tripsList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildTripCard(context, index)),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 111, 10, 10),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewTripLocationView(
                        trip: newTrip,
                      )),
            );
          }),
    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final trip = tripsList[index];

    return Container(
      color: Color.fromARGB(255, 72, 38, 115),
      padding: EdgeInsets.fromLTRB(4, 6, 4, 6),
      child: Card(
        color: Color.fromARGB(255, 246, 235, 244),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 25.0),
                child: Row(
                  children: [
                    Text(
                      trip.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 8.0),
                child: Row(
                  children: [
                    Text(
                        "${DateFormat('MMMMd').format(trip.startDate).toString()} - ${DateFormat('MMMMd').format(trip.endDate).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
                child: Row(
                  children: [
                    Text(
                      "INR ${trip.budget.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Spacer(),
                    Text(trip.travelType),
                  ],
                ),
              )

              //
            ],
          ),
        ),
      ),
    );
  }
}
