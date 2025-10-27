import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salon_appointment_app/provider/user_provider.dart';
import 'package:salon_appointment_app/screens/service_book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _services = [
    {'image': 'assets/hair.png', 'title': 'Haircut'},
    {'image': 'assets/nails.png', 'title': 'Nails'},
    {'image': 'assets/facial.png', 'title': 'Facial'},
    {'image': 'assets/coloring.png', 'title': 'Coloring'},
    {'image': 'assets/spa.png', 'title': 'Spa'},
    {'image': 'assets/waxing.png', 'title': 'Waxing'},
    {'image': 'assets/makeup.png', 'title': 'Makeup'},
    {'image': 'assets/message.png', 'title': 'Message'},
  ];

  final List<Map<String, dynamic>> _salons = [
    {
      'name': 'Glamour Lounge',
      'address': 'Main Street, Karachi',
      'services': ['Haircut', 'Facial', 'Manicure'],
    },
    {
      'name': 'Style Studio',
      'address': 'Shaheed-e-Millat, Karachi',
      'services': ['Hair Coloring', 'Waxing', 'Makeup'],
    },
    {
      'name': 'Beauty Bliss',
      'address': 'Gulshan Block 7, Karachi',
      'services': ['Spa', 'Haircut', 'Massage'],
    },
    {
      'name': 'Salon One',
      'address': 'Clifton Block 5, Karachi',
      'services': ['Facial', 'Threading', 'Nails'],
    },
    {
      'name': 'Elite Touch',
      'address': 'Bahadurabad, Karachi',
      'services': ['Makeup', 'Hair Styling', 'Waxing'],
    },
    {
      'name': 'Charm & Glow',
      'address': 'DHA Phase 6, Karachi',
      'services': ['Spa', 'Massage', 'Manicure'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Name of the User
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Hello, ${context.read<UserProvider>().currentUser.name}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSansYi(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Find the service you want, and treat yourself',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1A1A1A),
                  ),
                ),
                SizedBox(height: 10),
                // banner
                Image.asset('assets/banner.png'),
                SizedBox(height: 20),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'What do you want to do?',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSansYi(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // services
                GridView.builder(
                  itemCount: _services.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = _services[index];
                    return Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['title']!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 15),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Nearby Salons',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSansYi(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // salons
                ListView.builder(
                  itemCount: _salons.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final salon = _salons[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceBookScreen(salon: salon),
                        ),
                      ),
                      child: Card(
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
                            spacing: 10,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/salon.jpg',
                                  fit: BoxFit.cover,
                                  height: 180,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      salon['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      salon['address'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 6,
                                      children:
                                          (salon['services'] as List<String>)
                                              .map(
                                                (service) => Chip(
                                                  label: Text(
                                                    service,
                                                    style: TextStyle(
                                                      color: Color(0xff156778),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
