package com.dicoding.obatkaesa.utils;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

import com.dicoding.obatkaesa.model.Medicine;

import java.util.ArrayList;

public class DatabaseHelper extends SQLiteOpenHelper {

    public final static String databaseName = "db_obat_kaesa";
    public final static String tableMedicine = "medicine";
    public final static String fieldCode = "code";
    public final static String fieldName = "name";
    public final static String fieldType = "type";
    public final static String fieldPrice = "price";
    public final static String fieldImgUrl = "img_url";
    public final static String fieldDescription = "description";
    public final static String fieldQuantity = "quantity";


    public DatabaseHelper(@Nullable Context context) {
        super(context, databaseName, null, 1);
        SQLiteDatabase db = this.getWritableDatabase();
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        sqLiteDatabase.execSQL("CREATE TABLE " + tableMedicine + "(code PRIMARY KEY NOT NULL, name TEXT, type TEXT, price REAL, img_url TEXT, description TEXT, quantity INT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int oldVersion, int newVersion) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + tableMedicine);
        onCreate(sqLiteDatabase);
    }

    public void insertMedicine(Medicine medicine) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(fieldCode, medicine.getUuid());
        contentValues.put(fieldName, medicine.getName());
        contentValues.put(fieldType, medicine.getType());
        contentValues.put(fieldPrice, medicine.getPrice());
        contentValues.put(fieldImgUrl, medicine.getImgUrl());
        contentValues.put(fieldDescription, medicine.getDescription());
        contentValues.put(fieldQuantity, medicine.getQuantity());

        db.insert(tableMedicine, null, contentValues);
    }

    public Cursor ReadData() {
        SQLiteDatabase db = this.getWritableDatabase();
        return db.rawQuery("SELECT * FROM " + tableMedicine, null);
    }

    public ArrayList<Medicine> getAllMedicines() {
        ArrayList<Medicine> medicineArrayList = new ArrayList<>();
        Cursor cursor = ReadData();
        while (cursor.moveToNext()) {
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
}
