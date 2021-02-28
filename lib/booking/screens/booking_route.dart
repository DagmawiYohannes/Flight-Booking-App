import 'package:flutter/material.dart';
import 'package:Book_Flight/booking/booking.dart';

class BookingAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => BookingsList());
    }

    if (settings.name == AddUpdateBooking.routeName) {
      BookingArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateBooking(
                args: args,
              ));
    }

    if (settings.name == BookingDetail.routeName) {
      Booking booking = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => BookingDetail(
                booking: booking,
              ));
    }

    return MaterialPageRoute(builder: (context) => BookingsList());
  }
}

class BookingArgument {
  final Booking booking;
  final bool edit;
  BookingArgument({this.booking, this.edit});
}
