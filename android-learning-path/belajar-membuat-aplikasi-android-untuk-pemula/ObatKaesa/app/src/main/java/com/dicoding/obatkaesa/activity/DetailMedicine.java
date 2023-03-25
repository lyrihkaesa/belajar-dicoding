package com.dicoding.obatkaesa.activity;

import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.bumptech.glide.Glide;
import com.dicoding.obatkaesa.R;
import com.dicoding.obatkaesa.model.Medicine;

import java.util.Objects;

public class DetailMedicine extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail_medicine);

        Objects.requireNonNull(getSupportActionBar()).setTitle("Detail Obat");

        Medicine medicine = getIntent().getParcelableExtra("key_medicine");

        TextView tvName = findViewById(R.id.tv_name);
        TextView tvType = findViewById(R.id.tv_type);
        TextView tvQuantity = findViewById(R.id.tv_quantity);
        TextView tvPrice = findViewById(R.id.tv_price);
        TextView tvDescription = findViewById(R.id.tv_description);
        ImageView imgPhoto = findViewById(R.id.img_photo);

        tvName.setText(medicine.getName());
        String typeFormat = medicine.getType().substring(0, 1).toUpperCase() + medicine.getType().substring(1).toLowerCase();
        tvType.setText(typeFormat);
        String strQuantity = medicine.getQuantity().toString();
        tvQuantity.setText(strQuantity);
        tvPrice.setText(medicine.getPriceCurrencyId());
        tvDescription.setText(medicine.getDescription());
        Glide.with(this).load(medicine.getImgUrl()).into(imgPhoto);
    }
}