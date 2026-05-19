package com.springmvc.repository.recommend;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.recommend.FoodStatsDTO;

public class FoodStatsRowMapper implements RowMapper<FoodStatsDTO> {

    @Override
    public FoodStatsDTO mapRow(ResultSet rs, int rowNum) throws SQLException {

        FoodStatsDTO dto = new FoodStatsDTO();

        dto.setSelectedFood(rs.getString("selected_food"));
        dto.setCount(rs.getInt("count"));

        return dto;
    }
}