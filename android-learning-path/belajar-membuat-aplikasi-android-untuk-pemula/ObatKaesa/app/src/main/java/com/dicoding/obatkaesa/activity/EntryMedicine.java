package com.dicoding.obatkaesa.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

import com.dicoding.obatkaesa.MainActivity;
import com.dicoding.obatkaesa.R;
import com.dicoding.obatkaesa.model.Medicine;
import com.dicoding.obatkaesa.utils.DatabaseHelper;

import java.util.Objects;
import java.util.UUID;

public class EntryMedicine extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    EditText edtCode, edtName, edtType, edtPrice, edtQuantity, edtDescription, edtImageUrl;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_entry_medicine);

        Objects.requireNonNull(getSupportActionBar()).setTitle(getString(R.string.entry_data_medicine));

        databaseHelper = new DatabaseHelper(this);

        edtCode = findViewById(R.id.edt_code);

        UUID uuid = UUID.randomUUID();
        edtCode.setText(uuid.toString());

        edtName = findViewById(R.id.edt_name);
        edtType = findViewById(R.id.edt_type);
        edtPrice = findViewById(R.id.edt_price);
        edtQuantity = findViewById(R.id.edt_quantity);

        edtImageUrl = findViewById(R.id.edt_img_url);
        edtImageUrl.setText(getString(R.string.default_img_url));

        edtDescription = findViewById(R.id.edt_descripton);
        edtDescription.setText(getString(R.string.description));


    }

    public void SaveMedicine(View view) {
        // Membuat object medicine/obat
        Medicine medicine = new Medicine();

        // Set/Input/Masukan nilai ke object medicine/obat
        medicine.setUuid(edtCode.getText().toString());
        medicine.setName(edtName.getText().toString());
        medicine.setType(edtType.getText().toString());
        medicine.setPrice(Double.valueOf(edtPrice.getText().toString()));
        medicine.setQuantity(Integer.parseInt(edtQuantity.getText().toString()));
        medicine.setImgUrl(edtImageUrl.getText().toString());
        medicine.setDescription(edtDescription.getText().toString());

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