import 'package:equatable/equatable.dart';
import 'package:Book_Flight/booking/booking.dart';

class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingLoading extends BookingState {}

class BookingsLoadSuccess extends BookingState {
  final List<Booking> bookings;

  BookingsLoadSuccess([this.bookings = const []]);

  @override
  List<Object> get props => [bookings];
}

class BookingOperationFailure extends BookingState {}
