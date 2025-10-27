import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_appointment_app/provider/appointment_provider.dart';
import 'package:salon_appointment_app/provider/user_provider.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    // Fetch appointments once when screen opens
    if (appointmentProvider.appointments.isEmpty) {
      appointmentProvider.fetchAppointments(userProvider.currentUser.uid);
    }

    final appointments = appointmentProvider.appointments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff156778),
        title: const Text(
          'My Appointments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: appointments.isEmpty
          ? const Center(
              child: Text(
                'No appointments booked yet!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final services = List<Map<String, dynamic>>.from(
                  appointment['services'],
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['salon'] ?? 'Unknown Salon',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff156778),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '📅 ${appointment['day']}   ⏰ ${appointment['time']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Selected Services:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...services.map((service) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  service['name'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'PKR ${service['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const Divider(height: 16, color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'PKR ${appointment['totalPrice'].toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
