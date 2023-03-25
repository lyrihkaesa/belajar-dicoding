package com.dicoding.obatkaesa.activity;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.bumptech.glide.Glide;
import com.dicoding.obatkaesa.databinding.ActivityDetailMedicineBinding;
import com.dicoding.obatkaesa.model.Medicine;

import java.util.Objects;

public class DetailMedicine extends AppCompatActivity {
    ActivityDetailMedicineBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityDetailMedicineBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        Objects.requireNonNull(getSupportActionBar()).setTitle("Detail Obat");

        Medicine medicine = getIntent().getParcelableExtra("key_medicine");

        binding.tvName.setText(medicine.getName());
        binding.tvType.setText(medicine.getType());
        String strQuantity = medicine.getQuantity().toString();
        binding.tvQuantity.setText(strQuantity);
        binding.tvPrice.setText(medicine.getPriceCurrencyId());
        binding.tvDescription.setText(medicine.getDescription());
        Glide.with(this).load(medicine.getImgUrl()).into(binding.imgPhoto);
    }
}