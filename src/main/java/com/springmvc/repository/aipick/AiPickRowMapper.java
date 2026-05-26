package com.springmvc.repository.aipick;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.aipick.AiPickDTO;

public class AiPickRowMapper implements RowMapper<AiPickDTO> {

    @Override
    public AiPickDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
    	// Repository에서 맛집 정보 조회만 가져오고 Service에서 계산과 생성을 진행-유지보수가 쉬워서 
        AiPickDTO dto = new AiPickDTO();
        dto.setRestaurantId(rs.getLong("restaurant_id"));
        dto.setName(rs.getString("name"));
        dto.setCategoryName(rs.getString("category_name"));
        dto.setKakaoCategoryName(rs.getString("kakao_category_name"));
        dto.setAddress(rs.getString("address"));
        dto.setImageUrl(rs.getString("image_url"));
        dto.setRating(rs.getDouble("rating"));
        dto.setDistance(rs.getDouble("distance"));
        return dto;
    }
}