import 'package:flutter/material.dart';
import 'package:salon_appointment_app/model/service_model.dart';

class ServiceBookProvider with ChangeNotifier {
  // List of all available services
  final List<ServiceModel> _availableServices = [
    ServiceModel(
      name: 'Bob Cut',
      price: 1200,
      imageAsset: 'assets/services/bobcut.jpg',
    ),
    ServiceModel(
      name: 'Pedicure',
      price: 800,
      imageAsset: 'assets/services/pedicure.jpg',
    ),
    ServiceModel(
      name: 'Manicure',
      price: 700,
      imageAsset: 'assets/services/pedicure.jpg',
    ),
    ServiceModel(
      name: 'Facial',
      price: 1500,
      imageAsset: 'assets/services/facial.jpg',
    ),
    ServiceModel(
      name: 'Hair Coloring',
      price: 2500,
      imageAsset: 'assets/services/hair.jpg',
    ),
    ServiceModel(
      name: 'Waxing',
      price: 900,
      imageAsset: 'assets/services/waxing.jpg',
    ),
  ];

  // List of selected services
  final List<ServiceModel> _selectedServices = [];
  String selectedSalon = '';

  double _totalPrice = 0.0;

  List<ServiceModel> get availableServices => _availableServices;
  List<ServiceModel> get selectedServices => _selectedServices;
  double get totalPrice => _totalPrice;

  // Add service
  void addService(ServiceModel service) {
    if (!_selectedServices.contains(service)) {
      _selectedServices.add(service);
      _totalPrice += service.price;
      notifyListeners();
    }
  }

  // Remove service
  void removeService(ServiceModel service) {
    if (_selectedServices.contains(service)) {
      _selectedServices.remove(service);
      _totalPrice -= service.price;
      notifyListeners();
    }
  }

  // Clear all selections
  void clearServices() {
    _selectedServices.clear();
    _totalPrice = 0.0;
    notifyListeners();
  }
}
