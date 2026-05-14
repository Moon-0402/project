package com.springmvc.repository.member;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.dto.user.FindIdDTO;
import com.springmvc.dto.user.FindPwDTO;
import com.springmvc.dto.user.LoginDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.dto.user.PwChangeDTO;
import com.springmvc.dto.user.SignupDTO;
import com.springmvc.repository.admin.MemberManagementRowMapper;

@Repository
public class MemberRepositoryImpl implements MemberRepository {
	
	private JdbcTemplate template;
	
	@Autowired
	public void setJdbcTemplate(DataSource datasource) {
		this.template= new JdbcTemplate(datasource);
	}
	// 로그인
    @Override
    public LoginMemberDTO login(LoginDTO loginDTO) {
        String sql = "SELECT * FROM MEMBER WHERE login_id = ? AND password = ? ";

        List<LoginMemberDTO> result = template.query(
                sql,
                new LoginMemberRowMapper(),
                loginDTO.getId(),
                loginDTO.getPw()
        );

        if (result.isEmpty()) {
            return null;
        }

        return result.get(0);
    }
 // 회원가입
    @Override
    public void signup(SignupDTO signupDTO) {
        String sql = "INSERT INTO MEMBER "
                   + "(login_id, password, name, email, phone, role, created_at) "
                   + "VALUES (?, ?, ?, ?, ?, 'USER', NOW())";

        template.update(
                sql,
                signupDTO.getId(),
                signupDTO.getPw(),
                signupDTO.getName(),
                signupDTO.getEmail(),
                signupDTO.getPhone()
        );
    }
    @Override
    public String findId(FindIdDTO findIdDTO) {

        String sql = "select login_id from MEMBER where name = ? and email = ?";

        List<String> result = template.queryForList(
                sql,
                String.class,
                findIdDTO.getName(),
                findIdDTO.getEmail()
        );

        if (result.isEmpty()) {
            return null;
        }

        return result.get(0);
    }

    @Override
    public String findPw(FindPwDTO findPwDTO) {

        String sql = "select login_id from MEMBER where login_id = ? and name = ? and email = ?";

        List<String> result = template.queryForList(
                sql,
                String.class,
                findPwDTO.getId(),
                findPwDTO.getName(),
                findPwDTO.getEmail()
        );

        if (result.isEmpty()) {
            return null;
        }

        return result.get(0);
    }
	@Override
	public void changePassword(String loginId, PwChangeDTO pwChangeDTO) {
		// TODO Auto-generated method stub
		String sql = "update MEMBER set password=? where login_id=?";
		template.update(sql, pwChangeDTO.getPw(),loginId);
	}
	
	@Override
	public int countById(String id) {
	    String sql = "select count(*) from MEMBER where login_id = ?";
	    return template.queryForObject(sql, Integer.class, id);
	}

	@Override
	public int countByEmail(String email) {
	    String sql = "select count(*) from MEMBER where email = ?";
	    return template.queryForObject(sql, Integer.class, email);
	}

	@Override
	public void updateMyInfo(Long memberId, MemberUpdateDTO memberUpdateDTO) {
	    String sql = "update MEMBER set name = ?, email = ?, phone = ? where member_id = ?";

	    template.update(sql,
	            memberUpdateDTO.getName(),
	            memberUpdateDTO.getEmail(),
	            memberUpdateDTO.getPhone(),
	            memberId);
	}
	@Override
	public MemberManagementDTO findBymemberId(Long memberId) {
		// TODO Auto-generated method stub
		String sql = "select * from MEMBER where member_id = ?";
		return template.queryForObject(sql, new MemberManagementRowMapper(),memberId);
	}
	@Override
	public String findPasswordByLoginId(String loginId) {
	    String sql = "select password from MEMBER where login_id = ?";

	    return template.queryForObject(sql, String.class, loginId);
	}
	
	@Override
	public MemberManagementDTO findByLoginId(String loginId) {
	    String sql = "SELECT * FROM MEMBER WHERE login_id = ?";

	    List<MemberManagementDTO> result = template.query(
	            sql,
	            new MemberManagementRowMapper(),
	            loginId
	    );

	    if (result.isEmpty()) {
	        return null;
	    }

	    return result.get(0);
	}

	@Override
	public void insertKakaoMember(String loginId, String password, String name, String email) {
	    String sql = "INSERT INTO MEMBER "
	               + "(login_id, password, name, email, phone, role, created_at) "
	               + "VALUES (?, ?, ?, ?, NULL, 'USER', NOW())";

	    template.update(
	            sql,
	            loginId,
	            password,
	            name,
	            email
	    );
	}
	
	@Override
	public LoginMemberDTO findLoginMemberByLoginId(String loginId) {
	    String sql = "SELECT * FROM MEMBER WHERE login_id = ?";

	    List<LoginMemberDTO> result = template.query(
	            sql,
	            new LoginMemberRowMapper(),
	            loginId
	    );

	    if (result.isEmpty()) {
	        return null;
	    }

	    return result.get(0);
	}
}
