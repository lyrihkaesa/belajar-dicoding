package com.dicoding.obatkaesa.model;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.ArrayList;

public class Medicine implements Parcelable {

    private String uuid;
    private String name;
    private String type;
    private Double price;
    private String imgUrl;
    private String description;
    private ArrayList<String> benefit;
    private Integer quantity;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<String> getBenefit() {
        return benefit;
    }

    public void setBenefit(ArrayList<String> benefit) {
        this.benefit = benefit;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.uuid);
        dest.writeString(this.name);
        dest.writeString(this.type);
        dest.writeDouble(this.price);
        dest.writeString(this.imgUrl);
        dest.writeString(this.description);
        dest.writeInt(this.quantity);
    }

    public Medicine() {
    }

    private Medicine(Parcel in) {
        this.uuid = in.readString();
        this.name = in.readString();
        this.type = in.readString();
        this.price = in.readDouble();
        this.imgUrl = in.readString();
        this.description = in.readString();
        this.quantity = in.readInt();
    }

    public static final Parcelable.Creator<Medicine> CREATOR = new Parcelable.Creator<Medicine>() {
        @Override
        public Medicine createFromParcel(Parcel source) {
            return new Medicine(source);
        }

        @Override
        public Medicine[] newArray(int size) {
            return new Medicine[size];
        }
    };
}
