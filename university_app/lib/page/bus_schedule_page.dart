import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BusSchedulePage extends StatefulWidget {
  const BusSchedulePage({super.key});

  @override
  State<BusSchedulePage> createState() => _BusSchedulePageState();
}

class _BusSchedulePageState extends State<BusSchedulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedDirection = 'Starting'; // 'Starting' or 'Return'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<List<Map<String, dynamic>>> fetchBusData(String dayGroup) async {
    final response = await Supabase.instance.client
        .from('bus_times')
        .select('*, bus_routes(starting_location)')
        .eq('day_group', dayGroup)
        .eq('direction', _selectedDirection);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Schedule 2025"),
        backgroundColor: const Color(0xFF003366),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Sun-Thu"),
            Tab(text: "Friday"),
            Tab(text: "Saturday"),
          ],
        ),
      ),
      body: Column(
        children: [
          // Direction Selector (Starting vs Return)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                    value: 'Starting',
                    label: Text('To Campus'),
                    icon: Icon(Icons.school)),
                ButtonSegment(
                    value: 'Return',
                    label: Text('To City'),
                    icon: Icon(Icons.home)),
              ],
              selected: {_selectedDirection},
              onSelectionChanged: (value) {
                setState(() => _selectedDirection = value.first);
              },
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBusList("Sun-Thu"),
                _buildBusList("Friday"),
                _buildBusList("Saturday"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusList(String day) {
    return FutureBuilder(
      future: fetchBusData(day),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty)
          return const Center(child: Text("No schedule found"));

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade900,
                  child: Text(item['route_id'].toString(),
                      style: const TextStyle(color: Colors.white)),
                ),
                title: Text("Time: ${item['time']}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    Text("From: ${item['bus_routes']['starting_location']}"),
                trailing: Chip(
                  label: Text("${item['bus_count']} Bus"),
                  backgroundColor: Colors.blue.shade50,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
