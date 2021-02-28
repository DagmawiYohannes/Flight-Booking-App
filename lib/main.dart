import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Book_Flight/bloc_observer.dart';
import 'package:Book_Flight/booking/booking.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final BookingRepository bookingRepository = BookingRepository(
    dataProvider: BookingDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(
    BookingApp(bookingRepository: bookingRepository),
  );
}

class BookingApp extends StatelessWidget {
  final BookingRepository bookingRepository;

  BookingApp({@required this.bookingRepository}) : assert(bookingRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.bookingRepository,
      child: BlocProvider(
        create: (context) => BookingBloc(bookingRepository: this.bookingRepository)..add(BookingLoad()),
        child: MaterialApp(
          title: 'Booking App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: BookingAppRoute.generateRoute,
        ),
      ),
    );
  }
}
