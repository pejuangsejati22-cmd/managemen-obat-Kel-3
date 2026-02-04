<?php

namespace App\Http\Controllers;

use App\Models\Buku;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class BukuController extends Controller
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
        $data = Buku::all();
        return $this->formatResponse($data);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'idbuku' => 'required|unique:bukus,idbuku',
            'judul' => 'required',
            'pengarang' => 'required',
            'penerbit' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $buku = Buku::create($request->all());
        return $this->formatResponse([$buku], 201);
    }

    public function show($idbuku)
    {
        $buku = Buku::find($idbuku);
        if (!$buku) {
            return $this->formatResponse(['Buku tidak ditemukan'], 404, false);
        }
        $data = [
            'idbuku' => $buku->idbuku,
            'judul' => $buku->judul,
            'pengarang' => $buku->pengarang,
            'penerbit' => $buku->penerbit,
        ];
        return $this->formatResponse($data, 200);
    }

    public function update(Request $request, $idbuku)
    {
        $buku = Buku::find($idbuku);
        if (!$buku) {
            return $this->formatResponse(['Buku tidak ditemukan'], 404, false);
        }

        $validator = Validator::make($request->all(), [
            'judul' => 'required',
            'pengarang' => 'required',
            'penerbit' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->formatResponse($validator->errors()->all(), 422, false);
        }

        $buku->update($request->all());
        $data = [
            'idbuku' => $buku->idbuku,
            'judul' => $buku->judul,
            'pengarang' => $buku->pengarang,
            'penerbit' => $buku->penerbit,
        ];
        return $this->formatResponse($data, 200);
    }

    public function destroy($idbuku)
    {
        $buku = Buku::find($idbuku);
        if (!$buku) {
            return $this->formatResponse(['Buku tidak ditemukan'], 404, false);
        }

        $buku->delete();
        return $this->formatResponse(['Buku berhasil dihapus']);
    }
}
