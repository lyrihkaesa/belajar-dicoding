package com.dicoding.obatkaesa.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.dicoding.obatkaesa.databinding.ItemRowMedicineBinding;
import com.dicoding.obatkaesa.model.Medicine;

import java.util.ArrayList;

public class MedicineRecyclerViewAdapter extends RecyclerView.Adapter<MedicineRecyclerViewAdapter.MedicineRecyclerViewHolder> {
    private final ArrayList<Medicine> medicineArrayList;
    private OnItemClickCallback onItemClickCallback;

    public MedicineRecyclerViewAdapter(ArrayList<Medicine> medicineArrayList) {
        this.medicineArrayList = medicineArrayList;
    }

    public void setOnItemClickCallback(OnItemClickCallback onItemClickCallback) {
        this.onItemClickCallback = onItemClickCallback;
    }


    @NonNull
    @Override
    public MedicineRecyclerViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        ItemRowMedicineBinding binding = ItemRowMedicineBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
        return new MedicineRecyclerViewHolder(binding);
    }

    @Override
    public void onBindViewHolder(@NonNull MedicineRecyclerViewHolder holder, int position) {
        Medicine medicine = medicineArrayList.get(position);
        Glide.with(holder.itemView.getContext()).load(medicine.getImgUrl()).into(holder.binding.imgItemPhoto);
        holder.binding.tvItemName.setText(medicine.getName());
        holder.binding.tvItemPrice.setText(medicine.getPriceCurrencyId());

        holder.itemView.setOnClickListener(view -> onItemClickCallback.onItemClicked(medicineArrayList.get(position)));
    }

    @Override
    public int getItemCount() {
        return medicineArrayList.size();
    }

    // Class Holder untuk List Medicine RecyclerView
    public static class MedicineRecyclerViewHolder extends RecyclerView.ViewHolder {

        ItemRowMedicineBinding binding;

        public MedicineRecyclerViewHolder(@NonNull ItemRowMedicineBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }
    }

    public interface OnItemClickCallback {
        void onItemClicked(Medicine data);
    }
}
