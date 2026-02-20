import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrudDemoPage extends StatefulWidget {
  const CrudDemoPage({super.key});

  @override
  State<CrudDemoPage> createState() => _CrudDemoPageState();
}

class _CrudDemoPageState extends State<CrudDemoPage> {
  final _supabase = Supabase.instance.client;
  final _routeNameController = TextEditingController();
  final _timeController = TextEditingController();

  // ১. READ: ডাটাবেস থেকে রিয়েল-টাইম ডাটা পড়া (Stream ব্যবহার করা হয়েছে)
  final Stream<List<Map<String, dynamic>>> _busStream =
      Supabase.instance.client.from('bus_schedules').stream(primaryKey: ['id']);

  // ২. CREATE: নতুন ডাটা যোগ করা
  Future<void> _addBus() async {
    if (_routeNameController.text.isEmpty) return;
    try {
      await _supabase.from('bus_schedules').insert({
        'route_name': _routeNameController.text,
        'time': _timeController.text,
      });
      _routeNameController.clear();
      _timeController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Added Successfully!")));
    } catch (e) {
      print("Error adding: $e");
    }
  }

  // ৩. UPDATE: পুরনো ডাটা এডিট করা
  Future<void> _updateBus(int id) async {
    try {
      await _supabase.from('bus_schedules').update({
        'route_name': _routeNameController.text,
        'time': _timeController.text,
      }).eq('id', id);
      Navigator.pop(context); // ডায়ালগ বন্ধ করা
      _routeNameController.clear();
      _timeController.clear();
    } catch (e) {
      print("Error updating: $e");
    }
  }

  // ৪. DELETE: ডাটা মুছে ফেলা
  Future<void> _deleteBus(int id) async {
    try {
      await _supabase.from('bus_schedules').delete().eq('id', id);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Deleted Successfully!")));
    } catch (e) {
      print("Error deleting: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Manage Bus Schedule"), centerTitle: true),
      body: Column(
        children: [
          // ইনপুট বক্স
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                    controller: _routeNameController,
                    decoration: const InputDecoration(labelText: "Route Name")),
                TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                        labelText: "Time (e.g. 10:00 AM)")),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: _addBus, child: const Text("Add Schedule")),
              ],
            ),
          ),
          const Divider(thickness: 2),
          // লিস্ট ভিউ (রিয়েল টাইম)
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _busStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());
                final buses = snapshot.data!;
                return ListView.builder(
                  itemCount: buses.length,
                  itemBuilder: (context, index) {
                    final bus = buses[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(bus['route_name'] ?? 'No Name'),
                        subtitle: Text("Time: ${bus['time']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditDialog(bus)),
                            IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBus(bus['id'])),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // এডিট করার জন্য পপআপ
  void _showEditDialog(Map<String, dynamic> bus) {
    _routeNameController.text = bus['route_name'];
    _timeController.text = bus['time'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Schedule"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _routeNameController),
            TextField(controller: _timeController),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => _updateBus(bus['id']),
              child: const Text("Update")),
        ],
      ),
    );
  }
}
