package com.dicoding.obatkaesa;

import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;

import com.dicoding.obatkaesa.activity.About;
import com.dicoding.obatkaesa.activity.DetailMedicine;
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
        // Mengatur layout grid/linear pada RecyclerView dalam Vertical/Landscape
        if (getApplicationContext().getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
            binding.rvMedicines.setLayoutManager(new GridLayoutManager(this, 2));
        } else {
            binding.rvMedicines.setLayoutManager(new LinearLayoutManager(this));
        }

        // Inisialisasi adapter untuk RecyclerView
        MedicineRecyclerViewAdapter medicineRecyclerViewAdapter = new MedicineRecyclerViewAdapter(list);

        // Menyambungkan adapter diatas ke RecyclerView pada XML.
        binding.rvMedicines.setAdapter(medicineRecyclerViewAdapter);

        // onClick pindah ke DetailMedicine, dengan membawa data: Medicine
        medicineRecyclerViewAdapter.setOnItemClickCallback(data -> {
            Intent intentDetail = new Intent(MainActivity.this, DetailMedicine.class);
            intentDetail.putExtra("key_medicine", data);
            startActivity(intentDetail);
        });
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

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.about_page_item_menu) {
            Intent intent = new Intent(MainActivity.this, About.class);
            startActivity(intent);
        }
        return super.onOptionsItemSelected(item);
    }
}