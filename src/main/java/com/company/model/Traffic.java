package com.company.model;

import java.sql.Date;

public class Traffic {

    private int id;
    private Date date;
    private String routeFrom;
    private String routeTo;
    private int distance;
    private double cargo;
    private double pricePerKm;
    private double totalPrice;
    private int clientId;
    private TrafficStatus status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getRouteFrom() {
        return routeFrom;
    }

    public void setRouteFrom(String routeFrom) {
        this.routeFrom = routeFrom;
    }

    public String getRouteTo() {
        return routeTo;
    }

    public void setRouteTo(String routeTo) {
        this.routeTo = routeTo;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public double getCargo() {
        return cargo;
    }

    public void setCargo(double cargo) {
        this.cargo = cargo;
    }

    public double getPricePerKm() {
        return pricePerKm;
    }

    public void setPricePerKm(double pricePerKm) {
        this.pricePerKm = pricePerKm;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public TrafficStatus getStatus() {
        return status;
    }

    public void setStatus(TrafficStatus status) {
        this.status = status;
    }

    public static Builder newBuilder() {
        return new Traffic().new Builder();
    }

    public class Builder {
        private Builder() {
        }

        public Builder setId(int id) {
            Traffic.this.id = id;
            return this;
        }

        public Builder setDate(Date date) {
            Traffic.this.date = date;
            return this;
        }

        public Builder setRouteFrom(String routeFrom) {
            Traffic.this.routeFrom = routeFrom;
            return this;
        }

        public Builder setRouteTo(String routeTo) {
            Traffic.this.routeTo = routeTo;
            return this;
        }

        public Builder setDistance(int distance) {
            Traffic.this.distance = distance;
            return this;
        }

        public Builder setCargo(double cargo) {
            Traffic.this.cargo = cargo;
            return this;
        }

        public Builder setPricePerKm(double pricePerKm) {
            Traffic.this.pricePerKm = pricePerKm;
            return this;
        }

        public Builder setTotalPrice(double totalPrice) {
            Traffic.this.totalPrice = totalPrice;
            return this;
        }

        public Builder setClientId(int clientId) {
            Traffic.this.clientId = clientId;
            return this;
        }

        public Builder setTrafficStatus(TrafficStatus status) {
            Traffic.this.status = status;
            return this;
        }

        public Traffic build() {
            return Traffic.this;
        }
    }
}
