package com.springmvc.dto.recommend;

public class FoodStatsDTO {

    private String selectedFood;
    private int count;

    public FoodStatsDTO() {}

    public FoodStatsDTO(String selectedFood, int count) {
        this.selectedFood = selectedFood;
        this.count = count;
    }

    public String getSelectedFood() {
        return selectedFood;
    }

    public void setSelectedFood(String selectedFood) {
        this.selectedFood = selectedFood;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}