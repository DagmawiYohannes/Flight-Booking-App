import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Book_Flight/booking/bloc/bloc.dart';
import 'package:Book_Flight/booking/booking.dart';

class BookingsList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Bookings'),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (_, state) {
          if (state is BookingOperationFailure) {
            return Text('Could not do booking operation');
          }

          if (state is BookingsLoadSuccess) {
            final bookings = state.bookings;

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${bookings[idx].destination}'),
                subtitle: Text('${bookings[idx].date}'),
                onTap: () => Navigator.of(context).pushNamed(BookingDetail.routeName, arguments: bookings[idx]),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateBooking.routeName,
          arguments: BookingArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
