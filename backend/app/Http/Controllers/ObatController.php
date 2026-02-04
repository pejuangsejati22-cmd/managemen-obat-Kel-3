<?php

namespace App\Http\Controllers;

use App\Models\Obat;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ObatController extends Controller
{
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
        $data = Obat::all();
        return $this->formatResponse($data);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'idobat' => 'required|unique:obats,idobat',
            'nama' => 'required',
            'stok' => 'required|integer',
            'harga' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $obat = Obat::create($request->all());
        return $this->formatResponse([$obat], 201);
    }

    public function show($idobat)
    {
        $obat = Obat::find($idobat);
        if (!$obat) {
            return $this->formatResponse(['Obat tidak ditemukan'], 404, false);
        }
        $data = [
            'idobat' => $obat->idobat,
            'nama' => $obat->nama,
            'stok' => $obat->stok,
            'harga' => $obat->harga,
        ];
        return $this->formatResponse($data, 200);
    }

    public function update(Request $request, $idobat)
    {
        $obat = Obat::find($idobat);
        if (!$obat) {
            return $this->formatResponse(['Obat tidak ditemukan'], 404, false);
        }

        $validator = Validator::make($request->all(), [
            'nama' => 'required',
            'stok' => 'required|integer',
            'harga' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $obat->update($request->all());
        $data = [
            'nobarcode' => $obat->nobarcode,
            'nama' => $obat->nama,
            'stok' => $obat->stok,
            'harga' => $obat->harga,
        ];
        return $this->formatResponse($data, 200);
    }

    public function destroy($idobat)
    {
        $obat = Obat::find($idobat);
        if (!$obat) {
            return $this->formatResponse(['Obat tidak ditemukan'], 404, false);
        }

        $obat->delete();
        return $this->formatResponse(['Obat berhasil dihapus']);
    }
}
