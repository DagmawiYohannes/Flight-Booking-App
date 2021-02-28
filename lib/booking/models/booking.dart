import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Booking extends Equatable {
  Booking({this.id, @required this.from, @required this.destination, @required this.date, @required this.passengers});

  final String id;
  final String from;
  final String destination;
  final String date;
  final int passengers;

  @override
  List<Object> get props => [id, from, destination, date, passengers];

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      from: json['from'],
      destination: json['destination'],
      date: json['date'],
      passengers: json['passengers'],
    );
  }

  @override
  String toString() => 'Booking { id: $id, destination: $destination, passengers: $passengers }';
}
