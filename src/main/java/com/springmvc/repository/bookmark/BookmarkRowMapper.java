package com.springmvc.repository.bookmark;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.bookmark.Bookmark;

public class BookmarkRowMapper implements RowMapper<Bookmark> {

    @Override
    public Bookmark mapRow(ResultSet rs, int rowNum) throws SQLException {

        Bookmark bookmark = new Bookmark();

        // BOOKMARK 테이블
        bookmark.setBookmarkId(rs.getLong("bookmark_id"));
        bookmark.setMemberId(rs.getLong("member_id"));
        bookmark.setRestaurantId(rs.getLong("restaurant_id"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            bookmark.setCreatedAt(createdAt.toLocalDateTime());
        }

        // JOIN해서 가져온 값들
        bookmark.setRestaurantName(rs.getString("restaurant_name"));
        bookmark.setAddress(rs.getString("address"));
        bookmark.setPhone(rs.getString("phone"));
        bookmark.setPriceRange(rs.getString("price_range"));
        bookmark.setCategoryName(rs.getString("category_name"));

        return bookmark;
    }
}