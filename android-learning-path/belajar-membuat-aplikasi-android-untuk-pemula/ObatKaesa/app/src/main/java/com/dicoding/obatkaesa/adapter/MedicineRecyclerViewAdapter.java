package com.dicoding.obatkaesa.adapter;

import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.dicoding.obatkaesa.R;
import com.dicoding.obatkaesa.activity.DetailMedicine;
import com.dicoding.obatkaesa.model.Medicine;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;

public class MedicineRecyclerViewAdapter extends RecyclerView.Adapter<MedicineRecyclerViewAdapter.MedicineRecyclerViewHolder> {
    private final ArrayList<Medicine> medicineArrayList;

    public MedicineRecyclerViewAdapter(ArrayList<Medicine> medicineArrayList) {
        this.medicineArrayList = medicineArrayList;
    }

    @NonNull
    @Override
    public MedicineRecyclerViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_row_medicine, parent, false);
        return new MedicineRecyclerViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull MedicineRecyclerViewHolder holder, int position) {
        Medicine medicine = medicineArrayList.get(position);
        Glide.with(holder.itemView.getContext()).load(medicine.getImgUrl()).into(holder.imgPhoto);
        holder.tvName.setText(medicine.getName());
        holder.tvPrice.setText(medicine.getPriceCurrencyId());

        holder.itemView.setOnClickListener(v -> {
            Intent intentDetail = new Intent(holder.itemView.getContext(), DetailMedicine.class);
            intentDetail.putExtra("key_medicine", medicineArrayList.get(holder.getAdapterPosition()));
            holder.itemView.getContext().startActivity(intentDetail);
        });
    }

    @Override
    public int getItemCount() {
        return medicineArrayList.size();
    }

    // Class Holder untuk List Medicine RecyclerView
    public static class MedicineRecyclerViewHolder extends RecyclerView.ViewHolder {
        ImageView imgPhoto;
        TextView tvName, tvPrice;

        public MedicineRecyclerViewHolder(@NonNull View itemView) {
            super(itemView);
            imgPhoto = itemView.findViewById(R.id.img_item_photo);
            tvName = itemView.findViewById(R.id.tv_item_name);
            tvPrice = itemView.findViewById(R.id.tv_item_price);
        }
    }
}
