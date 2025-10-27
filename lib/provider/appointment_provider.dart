import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salon_appointment_app/model/service_model.dart';

class AppointmentProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedSalon;
  List<ServiceModel> _selectedServices = [];
  double _totalPrice = 0.0;
  String? _selectedDay;
  String? _selectedTime;

  List<Map<String, dynamic>> _appointments = [];

  List<Map<String, dynamic>> get appointments => _appointments;

  void setAppointmentDetails({
    required String salon,
    required List<ServiceModel> services,
    required double totalPrice,
    required String day,
    required String time,
  }) {
    _selectedSalon = salon;
    _selectedServices = services;
    _totalPrice = totalPrice;
    _selectedDay = day;
    _selectedTime = time;
    notifyListeners();
  }

  Future<bool> saveAppointment(String userId) async {
    if (_selectedSalon == null || _selectedServices.isEmpty) return false;

    try {
      await _firestore.collection('appointments').add({
        'userId': userId,
        'salon': _selectedSalon,
        'services': _selectedServices
            .map((s) => {'name': s.name, 'price': s.price})
            .toList(),
        'totalPrice': _totalPrice,
        'day': _selectedDay,
        'time': _selectedTime,
        'createdAt': Timestamp.now(),
      });
      await fetchAppointments(userId);
      return true;
    } catch (e) {
      debugPrint('Error saving appointment: $e');
      return false;
    }
  }

  Future<void> deleteAppointment(String appointmentId, String userId) async {
    try {
      await _firestore.collection('appointments').doc(appointmentId).delete();
      await fetchAppointments(userId); // Refresh local list after deletion
    } catch (e) {
      debugPrint('Error deleting appointment: $e');
    }
  }

  Future<void> fetchAppointments(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _appointments = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching appointments: $e');
    }
  }

  void clearAppointment() {
    _selectedSalon = null;
    _selectedServices = [];
    _totalPrice = 0.0;
    _selectedDay = null;
    _selectedTime = null;
    notifyListeners();
  }
}
