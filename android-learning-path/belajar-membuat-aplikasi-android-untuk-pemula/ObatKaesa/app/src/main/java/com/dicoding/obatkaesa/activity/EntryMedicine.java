package com.dicoding.obatkaesa.activity;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import com.dicoding.obatkaesa.MainActivity;
import com.dicoding.obatkaesa.R;
import com.dicoding.obatkaesa.model.Medicine;
import com.dicoding.obatkaesa.utils.DatabaseHelper;

public class EntryMedicine extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    EditText edtCode, edtName, edtType, edtPrice, edtQuantity;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_entry_medicine);

        databaseHelper = new DatabaseHelper(this);
        edtCode = findViewById(R.id.code_medicine);
        edtName = findViewById(R.id.name_medicine);
        edtType = findViewById(R.id.type_medicine);
        edtPrice = findViewById(R.id.price_medicine);
        edtQuantity = findViewById(R.id.quantity_medicine);
    }

    public void SaveMedicine(View view) {
        Medicine medicine = new Medicine();

        medicine.setUuid(edtCode.getText().toString());
        medicine.setName(edtName.getText().toString());
        medicine.setType(edtType.getText().toString());
        medicine.setPrice(Double.valueOf(edtPrice.getText().toString()));
        medicine.setQuantity(Integer.parseInt(edtQuantity.getText().toString()));
        medicine.setImgUrl("https://lyrihkaesa.github.io/img/medicine/sumagesic-4-tablet.jpeg");
        medicine.setDescription("Hanya deskripsi default");
        databaseHelper.insertMedicine(medicine);
        Intent intent = new Intent(EntryMedicine.this, MainActivity.class);
        startActivity(intent);
    }

    public void Cancel(View view) {
        Intent intent = new Intent(EntryMedicine.this, MainActivity.class);
        startActivity(intent);
    }
}