package com.springmvc.repository.member;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.admin.MemberManagementDTO;

public class MemberManagementRowMapper implements RowMapper<MemberManagementDTO>{
	 @Override
	    public MemberManagementDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
	        MemberManagementDTO member = new MemberManagementDTO();

	        member.setMemberId(rs.getLong("member_id"));
	        member.setLoginId(rs.getString("login_id"));
	        member.setName(rs.getString("name"));
	        member.setEmail(rs.getString("email"));
	        member.setPhone(rs.getString("phone"));
	        member.setRole(rs.getString("role"));
	        member.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
	        return member;
	    }
}
