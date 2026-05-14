package com.springmvc.repository.restaurant;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.restaurant.Restaurant;

public class RestaurantRowMapper implements RowMapper<Restaurant> {

    @Override
    public Restaurant mapRow(ResultSet rs, int rowNum) throws SQLException {
        Restaurant restaurant = new Restaurant();

        restaurant.setRestaurantId(rs.getLong("restaurant_id"));
        restaurant.setApiPlaceId(rs.getString("api_place_id"));
        restaurant.setCategoryId(rs.getLong("category_id"));
        restaurant.setName(rs.getString("name"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setLatitude(rs.getDouble("latitude"));
        restaurant.setLongitude(rs.getDouble("longitude"));
        restaurant.setPhone(rs.getString("phone"));
        restaurant.setOpeningHours(rs.getString("opening_hours"));
        restaurant.setPriceRange(rs.getString("price_range"));
        restaurant.setDescription(rs.getString("description"));
        restaurant.setStatus(rs.getString("status"));
        restaurant.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        restaurant.setKakaoCategoryName(rs.getString("kakao_category_name"));
        restaurant.setPlaceUrl(rs.getString("place_url"));
        return restaurant;
    }
}