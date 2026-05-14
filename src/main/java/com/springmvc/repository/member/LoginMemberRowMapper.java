package com.springmvc.repository.member;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.dto.user.LoginMemberDTO;


public class LoginMemberRowMapper implements RowMapper<LoginMemberDTO> {
	@Override
    public LoginMemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		LoginMemberDTO member = new LoginMemberDTO();

        member.setMemberId(rs.getLong("member_id"));
        member.setLoginId(rs.getString("login_id"));
        member.setName(rs.getString("name"));
        member.setRole(rs.getString("role"));
        

        return member;
    }
}
