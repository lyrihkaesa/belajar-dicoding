package com.dicoding.obatkaesa;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;

import com.dicoding.obatkaesa.activity.EntryMedicine;
import com.dicoding.obatkaesa.adapter.MedicineRecyclerViewAdapter;
import com.dicoding.obatkaesa.model.Medicine;
import com.dicoding.obatkaesa.utils.DatabaseHelper;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    private RecyclerView rvMedicines;
    private FloatingActionButton fab;
    private final ArrayList<Medicine> list = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        databaseHelper = new DatabaseHelper(this);

        rvMedicines = findViewById(R.id.rv_medicines);
        rvMedicines.setHasFixedSize(true);

        list.addAll(getListMedicines());
        showRecyclerList();

        fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, EntryMedicine.class);
                startActivity(intent);
            }
        });
    }

    private ArrayList<Medicine> getListMedicines() {
        ArrayList<Medicine> medicineArrayList = new ArrayList<>();

        Cursor cursor = databaseHelper.ReadData();
        list.clear();

        while (cursor.moveToNext()){
            Medicine medicine = new Medicine();
            medicine.setUuid(cursor.getString(0));
            medicine.setName(cursor.getString(1));
            medicine.setType(cursor.getString(2));
            medicine.setPrice(Double.valueOf(cursor.getString(3)));
            medicine.setImgUrl(cursor.getString(4));
            medicine.setDescription(cursor.getString(5));
            medicine.setQuantity(Integer.valueOf(cursor.getString(6)));

            medicineArrayList.add(medicine);
        }
        return medicineArrayList;
    }

    private void showRecyclerList() {
        rvMedicines.setLayoutManager(new LinearLayoutManager(this));
        MedicineRecyclerViewAdapter medicineRecyclerViewAdapter = new MedicineRecyclerViewAdapter(list);
        rvMedicines.setAdapter(medicineRecyclerViewAdapter);
//        medicineRecyclerViewAdapter.setOnItemClickCallback(this::showSelectedHero);
    }

}