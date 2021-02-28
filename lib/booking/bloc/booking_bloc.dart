import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Book_Flight/booking/bloc/bloc.dart';
import 'package:Book_Flight/booking/booking.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({@required this.bookingRepository})
      : assert(bookingRepository != null),
        super(BookingLoading());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is BookingLoad) {
      yield BookingLoading();
      try {
        final bookings = await bookingRepository.getBookings();
        yield BookingsLoadSuccess(bookings);
      } catch (_) {
        yield BookingOperationFailure();
      }
    }

    if (event is BookingCreate) {
      try {
        await bookingRepository.createBooking(event.booking);
        final bookings = await bookingRepository.getBookings();
        yield BookingsLoadSuccess(bookings);
      } catch (_) {
        yield BookingOperationFailure();
      }
    }

    if (event is BookingUpdate) {
      try {
        await bookingRepository.updateBooking(event.booking);
        final bookings = await bookingRepository.getBookings();
        yield BookingsLoadSuccess(bookings);
      } catch (_) {
        yield BookingOperationFailure();
      }
    }

    if (event is BookingDelete) {
      try {
        await bookingRepository.deleteBooking(event.booking.id);
        final bookings = await bookingRepository.getBookings();
        yield BookingsLoadSuccess(bookings);
      } catch (_) {
        yield BookingOperationFailure();
      }
    }
  }
}
