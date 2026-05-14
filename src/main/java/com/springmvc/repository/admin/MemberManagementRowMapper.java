package com.springmvc.repository.admin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.admin.MemberManagementDTO;

public class MemberManagementRowMapper implements RowMapper<MemberManagementDTO> {

    @Override
    public MemberManagementDTO mapRow(ResultSet rs, int rowNum) throws SQLException {

        MemberManagementDTO member = new MemberManagementDTO();

        member.setMemberId(rs.getLong("member_id"));
        member.setLoginId(rs.getString("login_id"));
        member.setName(rs.getString("name"));
        member.setEmail(rs.getString("email"));
        member.setPhone(rs.getString("phone"));
        member.setRole(rs.getString("role"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            member.setCreated_at(createdAt.toLocalDateTime());
        }

        return member;
    }
}