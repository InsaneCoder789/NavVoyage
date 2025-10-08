import 'package:equatable/equatable.dart';
import '../models/package_model.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectPackage extends BookingEvent {
  final Package package;
  SelectPackage(this.package);

  @override
  List<Object?> get props => [package];
}

class CustomizeItinerary extends BookingEvent {
  // itinerary is a simple Map: {'activities': List<String>, 'startDate': DateTime, 'endDate': DateTime}
  final Map<String, dynamic> itinerary;
  CustomizeItinerary(this.itinerary);

  @override
  List<Object?> get props => [itinerary];
}

class AddTravelers extends BookingEvent {
  final List<Map<String, dynamic>> travelers;
  AddTravelers(this.travelers);

  @override
  List<Object?> get props => [travelers];
}

class ConfirmBooking extends BookingEvent {}
