<?php

namespace App\Http\Controllers;

use App\Models\Motor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MotorController extends Controller
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
        $data = Motor::all();
        return $this->formatResponse($data);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'idmotor' => 'required|unique:motors,idmotor',
            'nama' => 'required',
            'stok' => 'required|integer',
            'harga' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $motor = Motor::create($request->all());
        return $this->formatResponse([$motor], 201);
    }

    public function show($idmotor)
    {
        $motor = Motor::find($idmotor);
        if (!$motor) {
            return $this->formatResponse(['Motor tidak ditemukan'], 404, false);
        }
        $data = [
            'idmotor' => $motor->idmotor,
            'nama' => $motor->nama,
            'stok' => $motor->stok,
            'harga' => $motor->harga,
        ];
        return $this->formatResponse($data, 200);
    }

    public function update(Request $request, $idmotor)
    {
        $motor = Motor::find($idmotor);
        if (!$motor) {
            return $this->formatResponse(['Motor tidak ditemukan'], 404, false);
        }

        $validator = Validator::make($request->all(), [
            'nama' => 'required',
            'stok' => 'required|integer',
            'harga' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $motor->update($request->all());
        $data = [
            'idmotor' => $motor->idmotor,
            'nama' => $motor->nama,
            'stok' => $motor->stok,
            'harga' => $motor->harga,
        ];
        return $this->formatResponse($data, 200);
    }

    public function destroy($idmotor)
    {
        $motor = Motor::find($idmotor);
        if (!$motor) {
            return $this->formatResponse(['Motor tidak ditemukan'], 404, false);
        }

        $motor->delete();
        return $this->formatResponse(['Motor berhasil dihapus']);
    }
}
