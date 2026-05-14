package com.springmvc.repository.inquiry;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.inquiry.InquiryDTO;

public class InquiryRowMapper implements RowMapper<InquiryDTO> {

    @Override
    public InquiryDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
        InquiryDTO inquiry = new InquiryDTO();

        inquiry.setInquiryId(rs.getLong("inquiry_id"));
        inquiry.setMemberId(rs.getLong("member_id"));
        inquiry.setLoginId(rs.getString("login_id"));
        inquiry.setName(rs.getString("name"));
        inquiry.setTitle(rs.getString("title"));
        inquiry.setContent(rs.getString("content"));
        inquiry.setStatus(rs.getString("status"));

        if (rs.getTimestamp("created_at") != null) {
            inquiry.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }

        return inquiry;
    }
}