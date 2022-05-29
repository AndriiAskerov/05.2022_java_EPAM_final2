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

    public Traffic(int id, Date date, String routeFrom, String routeTo, int distance, double cargo, double pricePerKm, double totalPrice) {
        this.id = id;
        this.date = date;
        this.routeFrom = routeFrom;
        this.routeTo = routeTo;
        this.distance = distance;
        this.cargo = cargo;
        this.pricePerKm = pricePerKm;
        this.totalPrice = totalPrice;
    }

    public Traffic(int id, Date date, String routeFrom, String routeTo, int distance, double cargo, double pricePerKm) {
        this(id, date, routeFrom, routeTo, distance, cargo, pricePerKm, (Math.ceil((double) distance * pricePerKm)));
    }

    public Traffic() {
        this(-1, Date.valueOf("1000-01-01"), "NULL", "NULL", 0, 0.00, 0.00, 0.00);
    }

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
}
