package com.springmvc.repository.inquiry;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.inquiry.InquiryReplyDTO;

public class InquiryReplyRowMapper implements RowMapper<InquiryReplyDTO> {

    @Override
    public InquiryReplyDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
        InquiryReplyDTO reply = new InquiryReplyDTO();

        reply.setReplyId(rs.getLong("reply_id"));
        reply.setInquiryId(rs.getLong("inquiry_id"));
        reply.setAdminId(rs.getLong("admin_id"));
        reply.setAdminLoginId(rs.getString("admin_login_id"));
        reply.setAdminName(rs.getString("admin_name"));
        reply.setContent(rs.getString("content"));

        if (rs.getTimestamp("created_at") != null) {
            reply.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }

        return reply;
    }
}