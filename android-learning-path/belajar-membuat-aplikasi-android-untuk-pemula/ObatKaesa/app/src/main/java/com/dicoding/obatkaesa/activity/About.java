package com.dicoding.obatkaesa.activity;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.dicoding.obatkaesa.databinding.ActivityAboutBinding;

import java.util.Objects;

public class About extends AppCompatActivity {
    ActivityAboutBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityAboutBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        Objects.requireNonNull(getSupportActionBar()).setTitle("Tentang");
    }
}