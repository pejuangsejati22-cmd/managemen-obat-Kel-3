import 'package:flutter/material.dart';
import 'package:frontend/models/obat_model.dart';
import 'package:frontend/services/api_service.dart';

class FormObatPage extends StatefulWidget {
  final Obat? obat; // Menggunakan model Obat
  const FormObatPage({super.key, this.obat});

  @override
  State<FormObatPage> createState() => _FormObatPageState();
}

class _FormObatPageState extends State<FormObatPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _namaController = TextEditingController();
  final _stokController = TextEditingController();
  final _hargaController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Jika data obat tidak null, berarti mode Edit
    if (widget.obat != null) {
      _idController.text = widget.obat!.idobat;
      _namaController.text = widget.obat!.nama;
      _stokController.text = widget.obat!.stok.toString();
      _hargaController.text = widget.obat!.harga.toInt().toString();
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    bool success;

    if (widget.obat == null) {
      // Panggil fungsi tambah obat
      success = await ApiService().addObat(
        _idController.text,
        _namaController.text,
        _stokController.text,
        _hargaController.text,
      );
    } else {
      // Panggil fungsi update obat
      success = await ApiService().updateObat(
        widget.obat!.idobat,
        _namaController.text,
        _stokController.text,
        _hargaController.text,
      );
    }

    setState(() => _isLoading = false);

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Data obat berhasil disimpan"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(
          context,
          true,
        ); // Kirim 'true' agar halaman list bisa refresh
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal menyimpan data"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.obat != null;
    final primaryColor = Colors.teal; // Menggunakan warna tema apotek

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(isEdit ? "Edit Obat" : "Tambah Obat"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Banner
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: ListTile(
                  leading: const Icon(
                    Icons.medication,
                    color: Colors.white,
                    size: 40,
                  ),
                  title: Text(
                    isEdit ? "Perbarui Data Obat" : "Input Obat Baru",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text(
                    "Pastikan stok dan harga sudah sesuai",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _idController,
                          decoration: const InputDecoration(
                            labelText: 'Kode/ID Obat',
                            prefixIcon: Icon(Icons.qr_code),
                          ),
                          enabled:
                              !isEdit, // ID tidak boleh diedit jika mode update
                          validator: (value) =>
                              value!.isEmpty ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _namaController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Obat',
                            prefixIcon: Icon(Icons.label),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _stokController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Stok',
                                  prefixIcon: Icon(Icons.inventory),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Wajib' : null,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                controller: _hargaController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Harga',
                                  prefixIcon: Icon(Icons.payments),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Wajib' : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    isEdit ? "UPDATE DATA" : "SIMPAN DATA",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
