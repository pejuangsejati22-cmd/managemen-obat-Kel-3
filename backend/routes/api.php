<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BukuController;
use App\Http\Controllers\MotorController;
use App\Http\Controllers\ObatController;
use App\Http\Controllers\PasienController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/obats', [ObatController::class, 'index']);
Route::post('/obats', [ObatController::class, 'store']);
Route::get('/obats/{idobat}', [ObatController::class, 'show']);
Route::put('/obats/{idobat}', [ObatController::class, 'update']);
Route::delete('/obats/{idobat}', [ObatController::class, 'destroy']);

Route::get('/buku', [BukuController::class, 'index']);
Route::post('/buku', [BukuController::class, 'store']);
Route::get('/buku/{idobat}', [BukuController::class, 'show']);
Route::put('/buku/{idobat}', [BukuController::class, 'update']);
Route::delete('/buku/{idobat}', [BukuController::class, 'destroy']);

Route::get('/motor', [MotorController::class, 'index']);
Route::post('/motor', [MotorController::class, 'store']);
Route::get('/motor/{idobat}', [MotorController::class, 'show']);
Route::put('/motor/{idobat}', [MotorController::class, 'update']);
Route::delete('/motor/{idobat}', [MotorController::class, 'destroy']);

Route::get('/pasien', [PasienController::class, 'index']);
Route::post('/pasien', [PasienController::class, 'store']);
Route::get('/pasien/{idobat}', [PasienController::class, 'show']);
Route::put('/pasien/{idobat}', [PasienController::class, 'update']);
Route::delete('/pasien/{idobat}', [PasienController::class, 'destroy']);
