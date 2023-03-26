package com.dicoding.obatkaesa.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.bumptech.glide.Glide;
import com.dicoding.obatkaesa.R;
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

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_detail, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.action_share) {
            Medicine medicine = getIntent().getParcelableExtra("key_medicine");

            // Membuat intent Action Share
            Intent shareIntent = new Intent(Intent.ACTION_SEND);

            // Input data medicine ke intent
            shareIntent.setType("text/plain");
            String message = "Beli " + medicine.getName() + " dengan harga " + medicine.getPriceCurrencyId() + " pada ObatKaesa!";
            shareIntent.putExtra(Intent.EXTRA_TEXT, message);
            startActivity(Intent.createChooser(shareIntent, "Bagikan dengan"));
        }
        return super.onOptionsItemSelected(item);
    }
}