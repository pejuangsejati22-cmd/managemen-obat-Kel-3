import 'package:flutter/material.dart';
import 'package:frontend/models/obat_model.dart';
import 'package:frontend/services/api_service.dart';

class FormObatPage extends StatefulWidget {
  final Obat? obat;
  const FormObatPage({super.key, this.obat});

  @override
  State<FormObatPage> createState() => _FormObatPageState();
}

class _FormObatPageState extends State<FormObatPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _idController;
  late final TextEditingController _namaController;
  late final TextEditingController _stokController;
  late final TextEditingController _hargaController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.obat?.idobat ?? '');
    _namaController = TextEditingController(text: widget.obat?.nama ?? '');
    _stokController = TextEditingController(text: widget.obat?.stok.toString() ?? '');
    _hargaController = TextEditingController(text: widget.obat?.harga.toInt().toString() ?? '');
  }

  @override
  void dispose() {
    _idController.dispose();
    _namaController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    final apiService = ApiService(); 
    bool success;

    if (widget.obat == null) {
      success = await apiService.addObat(
        _idController.text,
        _namaController.text,
        _stokController.text,
        _hargaController.text,
      );
    } else {
      success = await apiService.updateObat(
        widget.obat!.idobat,
        _namaController.text,
        _stokController.text,
        _hargaController.text,
      );
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data berhasil disinkronkan"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terjadi kesalahan sistem"), 
          backgroundColor: Colors.red
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType type = TextInputType.text,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        enabled: enabled,
        style: const TextStyle(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 22),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.obat != null;
    const Color primaryColor = Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(isEdit ? "Edit Detail Obat" : "Registrasi Obat"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // ICON EDIT DIMUNCULKAN DI SINI
                            Icon(Icons.edit_note_rounded, color: primaryColor, size: 28),
                            const SizedBox(width: 8),
                            const Text(
                              "Informasi Inventaris",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Akurasi data obat untuk pelayanan kesehatan terbaik.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: _idController,
                          label: "ID Referensi Obat",
                          icon: Icons.qr_code_2_rounded,
                          enabled: !isEdit,
                        ),
                        _buildTextField(
                          controller: _namaController,
                          label: "Nama Obat",
                          icon: Icons.medical_services_outlined,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _stokController,
                                label: "Stok",
                                icon: Icons.inventory_2_outlined,
                                type: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: _hargaController,
                                label: "Harga (Rp)",
                                icon: Icons.payments_outlined,
                                type: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 2,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24, width: 24,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                  )
                                : Text(
                                    isEdit ? "PERBARUI DATA" : "SIMPAN DATA",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shield_outlined, size: 16),
                    SizedBox(width: 5),
                    Text("Secure Data Encryption Active"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}