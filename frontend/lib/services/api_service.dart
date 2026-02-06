import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/obat_model.dart';

class ApiService {

  static const String baseUrl = "http://localhost:8000/api";

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // --- 1. OTENTIKASI ---

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      ).timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['data']['token'].toString());
        await prefs.setBool('isLoggedIn', true);
      }
      return data;
    } on SocketException {
      return {'status': false, 'data': 'Tidak ada koneksi internet'};
    } catch (e) {
      return {'status': false, 'data': 'Terjadi kesalahan: $e'};
    }
  }

  Future<Map<String, dynamic>> register(String nama, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {'Accept': 'application/json'},
        body: {'nama': nama, 'email': email, 'password': password},
      ).timeout(const Duration(seconds: 10));
      
      return jsonDecode(response.body);
    } catch (e) {
      return {'status': false, 'data': 'Gagal mendaftar: $e'};
    }
  }

  // --- 2. MANAJEMEN OBAT (CRUD) ---

  Future<List<Obat>> getObat() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/obats"),
        headers: await _getHeaders(),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((item) => Obat.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<bool> addObat(String id, String nama, String stok, String harga) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/obats"),
        headers: await _getHeaders(),
        body: jsonEncode({
          'idobat': id,
          'nama': nama,
          'stok': stok,
          'harga': harga,
        }),
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateObat(String id, String nama, String stok, String harga) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/obats/$id"),
        headers: await _getHeaders(),
        body: jsonEncode({
          'nama': nama,
          'stok': stok,
          'harga': harga,
        }),
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteObat(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/obats/$id"),
        headers: await _getHeaders(),
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}