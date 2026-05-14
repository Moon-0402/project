package com.springmvc.repository.restaurant;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.restaurant.RestaurantMapDTO;

public class RestaurantMapDTORowMapper implements RowMapper<RestaurantMapDTO> {

    @Override
    public RestaurantMapDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
        RestaurantMapDTO dto = new RestaurantMapDTO();

        dto.setRestaurantId(rs.getLong("restaurant_id"));
        dto.setName(rs.getString("name"));
        dto.setCategoryName(rs.getString("category_name"));
        dto.setAddress(rs.getString("address"));
        dto.setLatitude(rs.getDouble("latitude"));
        dto.setLongitude(rs.getDouble("longitude"));
        dto.setRating(rs.getDouble("rating"));

        return dto;
    }
}