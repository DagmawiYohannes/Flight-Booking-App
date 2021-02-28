import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Book_Flight/booking/booking.dart';

class BookingDetail extends StatelessWidget {
  static const routeName = 'bookingDetail';
  final Booking booking;

  BookingDetail({@required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.booking.destination}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateBooking.routeName,
              arguments: BookingArgument(booking: this.booking, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<BookingBloc>().add(BookingDelete(this.booking));
                Navigator.of(context).pushNamedAndRemoveUntil(BookingsList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Destination: ${this.booking.destination}'),
              subtitle: Text('Date: ${this.booking.date}'),
            ),
            Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(this.booking.date),
          ],
        ),
      ),
    );
  }
}
