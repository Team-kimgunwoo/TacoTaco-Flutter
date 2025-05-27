import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HomeViewModel extends ChangeNotifier {
  LatLng? _userLocation;
  List<LatLng> _locations = [];

  LatLng? get userLocation => _userLocation;
  List<LatLng> get locations => _locations;

  void updateLocation(LatLng location) {
    _userLocation = location;
    notifyListeners();
  }

  void setMarkers(List<LatLng> newMarkers) {
    _locations = newMarkers;
    notifyListeners();
  }
}
