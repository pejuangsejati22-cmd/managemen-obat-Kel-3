<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Obat extends Model
{
    use HasFactory;
    protected $primaryKey = 'idobat';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    protected $fillable = ['idobat', 'nama', 'stok', 'harga'];
}
