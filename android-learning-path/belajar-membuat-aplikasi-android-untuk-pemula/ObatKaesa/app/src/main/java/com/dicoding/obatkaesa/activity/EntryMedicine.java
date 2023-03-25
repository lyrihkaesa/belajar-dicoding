package com.dicoding.obatkaesa.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.dicoding.obatkaesa.MainActivity;
import com.dicoding.obatkaesa.R;
import com.dicoding.obatkaesa.databinding.ActivityEntryMedicineBinding;
import com.dicoding.obatkaesa.model.Medicine;
import com.dicoding.obatkaesa.utils.DatabaseHelper;

import java.util.Objects;
import java.util.UUID;

public class EntryMedicine extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    ActivityEntryMedicineBinding binding;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityEntryMedicineBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        Objects.requireNonNull(getSupportActionBar()).setTitle(getString(R.string.entry_data_medicine));

        databaseHelper = new DatabaseHelper(this);

        UUID uuid = UUID.randomUUID();
        binding.edtCode.setText(uuid.toString());
        binding.edtImgUrl.setText(getString(R.string.default_img_url));
        binding.edtDescripton.setText(getString(R.string.description));


    }

    public void SaveMedicine(View view) {
        // Membuat object medicine/obat
        Medicine medicine = new Medicine();

        // Set/Input/Masukan nilai ke object medicine/obat
        medicine.setUuid(binding.edtCode.getText().toString());
        medicine.setName(binding.edtName.getText().toString());
        medicine.setType(binding.edtType.getText().toString());
        medicine.setPrice(Double.valueOf(binding.edtPrice.getText().toString()));
        medicine.setQuantity(Integer.parseInt(binding.edtQuantity.getText().toString()));
        medicine.setImgUrl(binding.edtImgUrl.getText().toString());
        medicine.setDescription(binding.edtDescripton.getText().toString());

        // insert object medicine/obat ke database
        databaseHelper.insertMedicine(medicine);

        // Ganti dari halaman EntryMedicine ke MainActivity
        Intent intent = new Intent(EntryMedicine.this, MainActivity.class);
        startActivity(intent);
    }

    public void Cancel(View view) {
        // Ganti dari halaman EntryMedicine ke MainActivity
        Intent intent = new Intent(EntryMedicine.this, MainActivity.class);
        startActivity(intent);
    }
}