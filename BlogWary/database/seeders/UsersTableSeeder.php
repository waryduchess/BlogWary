<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UsersTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('users')->insert([
            'name' => 'Erik Santiago',
            'email' => 'erik@example.com',
            'password' => Hash::make('12345678'),
            'role' => 'user',
            'bio' => 'Ingeniero en software',
            'avatar' => null,
            'created_at' => now(),
            'updated_at' => now()
        ]);
    }
}
