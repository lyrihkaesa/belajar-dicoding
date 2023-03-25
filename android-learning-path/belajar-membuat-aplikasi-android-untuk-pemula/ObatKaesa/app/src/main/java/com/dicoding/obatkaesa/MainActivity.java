package com.dicoding.obatkaesa;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;

import com.dicoding.obatkaesa.activity.EntryMedicine;
import com.dicoding.obatkaesa.adapter.MedicineRecyclerViewAdapter;
import com.dicoding.obatkaesa.databinding.ActivityMainBinding;
import com.dicoding.obatkaesa.model.Medicine;
import com.dicoding.obatkaesa.utils.DatabaseHelper;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.Objects;
import java.util.Random;
import java.util.UUID;

public class MainActivity extends AppCompatActivity {
    private ActivityMainBinding binding;
    DatabaseHelper databaseHelper;
    private final ArrayList<Medicine> list = new ArrayList<>();
    private static final String PREFS = "prefs_obatkaesa";
    private static final String PREF_APP_FIRST_RUN = "isAppFirstRun";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        Objects.requireNonNull(getSupportActionBar()).setTitle("Daftar Obat");

        SharedPreferences settings = this.getSharedPreferences(PREFS, 0);
        boolean firstRun = settings.getBoolean(PREF_APP_FIRST_RUN, true);

        databaseHelper = new DatabaseHelper(this);

        if (firstRun) {
            addListStringMedicineToDatabase();
            settings.edit().putBoolean(PREF_APP_FIRST_RUN, false).apply();
        }

        binding.rvMedicines.setHasFixedSize(true);

        list.clear();
        list.addAll(databaseHelper.getAllMedicines());
        showRecyclerList();

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(view -> {
            Intent intent = new Intent(MainActivity.this, EntryMedicine.class);
            startActivity(intent);
        });
    }

    private void showRecyclerList() {
        binding.rvMedicines.setLayoutManager(new LinearLayoutManager(this));
        MedicineRecyclerViewAdapter medicineRecyclerViewAdapter = new MedicineRecyclerViewAdapter(list);
        binding.rvMedicines.setAdapter(medicineRecyclerViewAdapter);
//        medicineRecyclerViewAdapter.setOnItemClickCallback(this::showSelectedHero);
    }

    private void addListStringMedicineToDatabase() {
        String[] dataName = getResources().getStringArray(R.array.data_name);
        String[] dataType = getResources().getStringArray(R.array.data_type);
        String[] dataDescription = getResources().getStringArray(R.array.data_description);
        String[] dataImgUrl = getResources().getStringArray(R.array.data_img_url);
        int[] dataPrice = getResources().getIntArray(R.array.data_price);

        for (int i = 0; i < dataName.length; i++) {
            Medicine medicine = new Medicine();

            medicine.setName(dataName[i]);
            medicine.setType(dataType[i]);
            medicine.setDescription(dataDescription[i]);
            medicine.setImgUrl(dataImgUrl[i]);
            medicine.setPrice((double) dataPrice[i]);

            Random random = new Random();
            medicine.setQuantity(random.nextInt(91) + 10);

            UUID uuid = UUID.randomUUID();
            medicine.setUuid(String.valueOf(uuid));

            // insert object medicine/obat ke database
            databaseHelper.insertMedicine(medicine);
        }

    }
}