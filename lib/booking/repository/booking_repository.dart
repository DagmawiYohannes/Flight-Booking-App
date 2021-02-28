import 'package:meta/meta.dart';
import 'package:Book_Flight/booking/booking.dart';

class BookingRepository {
  final BookingDataProvider dataProvider;

  BookingRepository({@required this.dataProvider}) : assert(dataProvider != null);

  Future<Booking> createBooking(Booking booking) async {
    return await dataProvider.createBooking(booking);
  }

  Future<List<Booking>> getBookings() async {
    return await dataProvider.getBookings();
  }

  Future<void> updateBooking(Booking booking) async {
    await dataProvider.updateBooking(booking);
  }

  Future<void> deleteBooking(String id) async {
    await dataProvider.deleteBooking(id);
  }
}
