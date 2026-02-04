<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Motor extends Model
{
    use HasFactory;
    protected $primaryKey = 'idmotor';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    protected $fillable = ['idmotor', 'nama', 'stok', 'harga'];
}
