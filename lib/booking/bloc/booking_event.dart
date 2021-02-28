import 'package:equatable/equatable.dart';
import 'package:Book_Flight/booking/booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class BookingLoad extends BookingEvent {
  const BookingLoad();

  @override
  List<Object> get props => [];
}

class BookingCreate extends BookingEvent {
  final Booking booking;

  const BookingCreate(this.booking);

  @override
  List<Object> get props => [booking];

  @override
  String toString() => 'Booking Created {booking: $booking}';
}

class BookingUpdate extends BookingEvent {
  final Booking booking;

  const BookingUpdate(this.booking);

  @override
  List<Object> get props => [booking];

  @override
  String toString() => 'Booking Updated {booking: $booking}';
}

class BookingDelete extends BookingEvent {
  final Booking booking;

  const BookingDelete(this.booking);

  @override
  List<Object> get props => [booking];

  @override
  toString() => 'Booking Deleted {booking: $booking}';
}
