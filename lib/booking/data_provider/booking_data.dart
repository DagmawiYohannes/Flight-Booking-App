import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:Book_Flight/booking/models/booking.dart';
import 'package:http/http.dart' as http;

class BookingDataProvider {
  final _baseUrl = 'http://localhost:4000';
  final http.Client httpClient;

  BookingDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Booking> createBooking(Booking booking) async {
    final response = await httpClient.post(
      Uri.http('localhost:4000', '/bookings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'from': booking.from,
        'destination': booking.destination,
        'date': booking.date,
        'passengers': booking.passengers,
      }),
    );

    if (response.statusCode == 200) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create booking.');
    }
  }

  Future<List<Booking>> getBookings() async {
    final response = await httpClient.get('$_baseUrl/bookings');

    if (response.statusCode == 200) {
      final bookings = jsonDecode(response.body) as List;
      print(bookings);
      return bookings.map((booking) => Booking.fromJson(booking)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<void> deleteBooking(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/bookings/<$id>',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete booking.');
    }
  }

  Future<void> updateBooking(Booking booking) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/bookings/<${booking.id}>',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': booking.id,
        'from': booking.from,
        'destination': booking.destination,
        'date': booking.date,
        'passengers': booking.passengers,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update booking.');
    }
  }
}
