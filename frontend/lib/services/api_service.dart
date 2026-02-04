import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/obat_model.dart';

class ApiService {
 
  static const String baseUrl = "http://192.168.56.1:8000/api";

  // --- 1. OTENTIKASI ---

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/login"),
            body: {'email': email, 'password': password},
          )
          .timeout(
            const Duration(seconds: 10),
          ); 

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['data']['token']);
        await prefs.setBool('isLoggedIn', true);
      }
      return data;
    } catch (e) {
      return {'status': false, 'data': 'Kesalahan Koneksi: $e'}; //
    }
  }

  Future<Map<String, dynamic>> register(
    String nama,
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/register"),
            body: {'nama': nama, 'email': email, 'password': password},
          )
          .timeout(const Duration(seconds: 10));
      return jsonDecode(response.body);
    } catch (e) {
      return {'status': false, 'data': 'Gagal terhubung ke backend: $e'};
    }
  }

  // --- 2. MANAJEMEN OBAT (CRUD) ---

  Future<List<Obat>> getObat() async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/obats"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> data = body['data'];
        return data.map((item) => Obat.fromJson(item)).toList();
      } else {
        throw Exception("Gagal mengambil data obat");
      }
    } catch (e) {
      throw Exception(
        "Kesalahan Koneksi: $e",
      ); 
    }
  }

  Future<bool> addObat(
    String id,
    String nama,
    String stok,
    String harga,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/obats"),
            body: {'idobat': id, 'nama': nama, 'stok': stok, 'harga': harga},
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateObat(
    String id,
    String nama,
    String stok,
    String harga,
  ) async {
    try {
      final response = await http
          .put(
            Uri.parse("$baseUrl/obats/$id"),
            body: {'nama': nama, 'stok': stok, 'harga': harga},
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteObat(String id) async {
    try {
      final response = await http
          .delete(Uri.parse("$baseUrl/obats/$id"))
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
