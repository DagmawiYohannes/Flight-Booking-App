import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Book_Flight/booking/booking.dart';

class AddUpdateBooking extends StatefulWidget {
  static const routeName = 'bookingAddUpdate';
  final BookingArgument args;

  AddUpdateBooking({this.args});
  @override
  _AddUpdateBookingState createState() => _AddUpdateBookingState();
}

class _AddUpdateBookingState extends State<AddUpdateBooking> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _booking = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Booking" : "Add New Booking"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               TextFormField(
                  initialValue: widget.args.edit ? widget.args.booking.from : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter booking from';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'From'),
                  onSaved: (value) {
                    this._booking["from"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.booking.destination : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter booking destination';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'To'),
                  onSaved: (value) {
                    setState(() {
                      this._booking["destination"] = value;
                    });
                  }),
             
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.booking.passengers.toString() : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter booking passengers';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Number of Passengers'),
                  onSaved: (value) {
                    setState(() {
                      this._booking["passengers"] = int.parse(value);
                    });
                  }),
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.booking.date : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter booking date';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Booking Date'),
                  onSaved: (value) {
                    setState(() {
                      this._booking["date"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final BookingEvent event = widget.args.edit
                          ? BookingUpdate(
                              Booking(
                                id: widget.args.booking.id,
                                destination: this._booking["destination"],
                                from: this._booking["from"],
                                passengers: this._booking["passengers"],
                                date: this._booking["date"],
                              ),
                            )
                          : BookingCreate(
                              Booking(
                                destination: this._booking["destination"],
                                from: this._booking["from"],
                                passengers: this._booking["passengers"],
                                date: this._booking["date"],
                              ),
                            );
                      BlocProvider.of<BookingBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(BookingsList.routeName, (route) => false);
                    }
                  },
                  label: Text('SAVE'),
                  icon: Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
