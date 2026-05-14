package com.springmvc.repository.restaurant;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.restaurant.RestaurantDTO;

public class RestaurantDTORowMapper implements RowMapper<RestaurantDTO> {

    @Override
    public RestaurantDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
        RestaurantDTO dto = new RestaurantDTO();

        dto.setRestaurantId(rs.getLong("restaurant_id"));
        dto.setName(rs.getString("name"));
        dto.setCategoryName(rs.getString("category_name"));
        dto.setRating(rs.getDouble("rating"));
        dto.setImageUrl(rs.getString("image_url"));
        dto.setLatitude(rs.getDouble("latitude"));
        dto.setLongitude(rs.getDouble("longitude"));

        try {
            dto.setDistance(rs.getDouble("distance"));
        } catch (SQLException e) {
            dto.setDistance(null);
        }

        return dto;
    }
}