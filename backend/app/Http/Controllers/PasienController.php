<?php

namespace App\Http\Controllers;

use App\Models\Pasien;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PasienController extends Controller
{
    //
    private function formatResponse($data, $code = 200, $status = true)
    {
        return response()->json([
            'code' => (int)$code,
            'status' => $status ? true : false,
            'data' => $data
        ], $code);
    }
    public function index()
    {
        $data = Pasien::all();
        return $this->formatResponse($data);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'idpasien' => 'required|unique:pasiens,idpasien',
            'nama' => 'required',
            'umur' => 'required|integer',
            'alamat' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $pasien = Pasien::create($request->all());
        return $this->formatResponse([$pasien], 201);
    }

    public function show($idpasien)
    {
        $pasien = Pasien::find($idpasien);
        if (!$pasien) {
            return $this->formatResponse(['Pasien tidak ditemukan'], 404, false);
        }
        $data = [
            'idpasien' => $pasien->idpasien,
            'nama' => $pasien->nama,
            'umur' => $pasien->umur,
            'harga' => $pasien->harga,
        ];
        return $this->formatResponse($data, 200);
    }

    public function update(Request $request, $idpasien)
    {
        $pasien = Pasien::find($idpasien);
        if (!$pasien) {
            return $this->formatResponse(['Pasien tidak ditemukan'], 404, false);
        }

        $validator = Validator::make($request->all(), [
            'nama' => 'required',
            'umur' => 'required|integer',
            'alamat' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $pasien->update($request->all());
        $data = [
            'idpasien' => $pasien->idpasien,
            'nama' => $pasien->nama,
            'umur' => $pasien->umur,
            'alamat' => $pasien->alamat,
        ];
        return $this->formatResponse($data, 200);
    }

    public function destroy($idpasien)
    {
        $pasien = Pasien::find($idpasien);
        if (!$pasien) {
            return $this->formatResponse(['Pasien tidak ditemukan'], 404, false);
        }

        $pasien->delete();
        return $this->formatResponse(['Pasien berhasil dihapus']);
    }
}
