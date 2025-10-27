import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_appointment_app/provider/appointment_provider.dart';
import 'package:salon_appointment_app/provider/service_book_provider.dart';
import 'package:salon_appointment_app/provider/user_provider.dart';

class ServiceBookScreen extends StatefulWidget {
  final Map<String, dynamic> salon;
  const ServiceBookScreen({super.key, required this.salon});

  @override
  State<ServiceBookScreen> createState() => _ServiceBookScreenState();
}

class _ServiceBookScreenState extends State<ServiceBookScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServiceBookProvider>();
    final _dayController = TextEditingController();
    final _timeController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Provider.of<ServiceBookProvider>(
              context,
              listen: false,
            ).clearServices();
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          widget.salon['name'],
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.availableServices.length,
              itemBuilder: (context, index) {
                final service = provider.availableServices[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            service.imageAsset,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported, size: 60),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "PKR ${service.price.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        provider.addService(service),
                                    icon: Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        provider.removeService(service),
                                    icon: Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _dayController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Day',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff156778),
                            ),
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: Color(0xff156778),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a day';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Time',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff156778),
                            ),
                            prefixIcon: const Icon(
                              Icons.access_time,
                              color: Color(0xff156778),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a time';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),

                      const Text(
                        'Total Price:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'PKR ${provider.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final appointmentProvider =
                            Provider.of<AppointmentProvider>(
                              context,
                              listen: false,
                            );
                        final userProvider = Provider.of<UserProvider>(
                          context,
                          listen: false,
                        );
                        final serviceProvider =
                            Provider.of<ServiceBookProvider>(
                              context,
                              listen: false,
                            );

                        appointmentProvider.setAppointmentDetails(
                          salon: widget.salon['name'],
                          services: serviceProvider.selectedServices,
                          totalPrice: serviceProvider.totalPrice,
                          day: _dayController.text,
                          time: _timeController.text,
                        );

                        // Save appointment for current user
                        bool success = await appointmentProvider
                            .saveAppointment(userProvider.currentUser.uid);

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Booking Confirmed!')),
                          );
                          // Clear after saving
                          serviceProvider.clearServices();
                          appointmentProvider.clearAppointment();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Booking failed!')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff156778),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
