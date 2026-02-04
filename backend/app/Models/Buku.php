<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Buku extends Model
{
    use HasFactory;
    protected $primaryKey = 'idbuku';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    protected $fillable = ['idbuku', 'judul', 'pengarang', 'penerbit'];
}
