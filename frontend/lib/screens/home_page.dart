import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/obat_model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/screens/login_page.dart';
import 'package:frontend/screens/form_obat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Obat>> _futureObats;

  @override
  void initState() {
    super.initState();
    _refreshObats();
  }

  // Mengambil data obat dari API
  void _refreshObats() {
    setState(() {
      _futureObats = ApiService().getObat();
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus token dan status login
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  void _deleteObat(String id) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Obat"),
        content: const Text("Yakin ingin menghapus data obat ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm) {
      bool success = await ApiService().deleteObat(id);
      if (success) {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data obat berhasil dihapus")),
          );
        _refreshObats();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal, // Menggunakan warna tema apotek
        title: const Text(
          "Daftar Obat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Refresh data setelah kembali dari form tambah
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormObatPage()),
          );
          if (result == true) _refreshObats();
        },
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add),
        label: const Text("Tambah Obat"),
      ),
      body: Column(
        children: [
          // Banner Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Kelola stok dan harga obat apotek Anda di sini.",
                    style: TextStyle(color: Colors.teal[50], fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Obat>>(
              future: _futureObats,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Belum ada data obat di database."),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final obat = snapshot.data![index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal[50],
                          child: const Icon(
                            Icons.medication,
                            color: Colors.teal,
                          ),
                        ),
                        title: Text(
                          obat.nama,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Stok: ${obat.stok} | Rp ${obat.harga}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FormObatPage(obat: obat),
                                  ),
                                );
                                if (res == true) _refreshObats();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteObat(
                                obat.idobat,
                              ), // Menggunakan idobat
                            ),
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
}
