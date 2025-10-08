import 'package:equatable/equatable.dart';
import '../models/package_model.dart';

abstract class BookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class PackageSelected extends BookingState {
  final Package selectedPackage;
  PackageSelected(this.selectedPackage);

  @override
  List<Object?> get props => [selectedPackage];
}

class ItineraryCustomized extends BookingState {
  final Map<String, dynamic> itinerary;
  ItineraryCustomized(this.itinerary);

  @override
  List<Object?> get props => [itinerary];
}

class TravelersAdded extends BookingState {
  final List<Map<String, dynamic>> travelers;
  TravelersAdded(this.travelers);

  @override
  List<Object?> get props => [travelers];
}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingFailure extends BookingState {
  final String message;
  BookingFailure(this.message);

  @override
  List<Object?> get props => [message];
}
