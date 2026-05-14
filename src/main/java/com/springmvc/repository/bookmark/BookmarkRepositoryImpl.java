package com.springmvc.repository.bookmark;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.bookmark.Bookmark;

@Repository
public class BookmarkRepositoryImpl implements BookmarkRepository {

    @Autowired
    private JdbcTemplate template;

    @Override
    public List<Bookmark> getBookmarkList(Long memberId) {

        String sql =
            "SELECT " +
            "    b.bookmark_id, " +
            "    b.member_id, " +
            "    b.restaurant_id, " +
            "    b.created_at, " +
            "    r.name AS restaurant_name, " +
            "    r.address, " +
            "    r.phone, " +
            "    r.price_range, " +
            "    c.category_name " +
            "FROM BOOKMARK b " +
            "JOIN RESTAURANT r ON b.restaurant_id = r.restaurant_id " +
            "LEFT JOIN CATEGORY c ON r.category_id = c.category_id " +
            "WHERE b.member_id = ? " +
            "ORDER BY b.created_at DESC";

        return template.query(sql, new BookmarkRowMapper(), memberId);
    }

    @Override
    public void deleteBookmark(Long bookmarkId, Long memberId) {

        String sql =
            "DELETE FROM BOOKMARK " +
            "WHERE bookmark_id = ? AND member_id = ?";

        template.update(sql, bookmarkId, memberId);
    }
    
    @Override
    public void insertBookmark(Long memberId, Long restaurantId) {

        String sql = "INSERT INTO BOOKMARK (member_id, restaurant_id) VALUES (?, ?)";

        template.update(sql, memberId, restaurantId);
    }
}