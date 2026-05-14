package com.springmvc.repository.admin;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;

@Repository
public class AdminRepositoryImpl implements AdminRepository {

    private JdbcTemplate template;

    @Autowired
    public void setJdbcTemplate(DataSource datasource) {
        this.template = new JdbcTemplate(datasource);
    }

    @Override
    public MemberManagementDTO findBymemberId(Long memberId) {
        String sql = """
            select member_id, login_id, password, name, email, phone, role, created_at
            from MEMBER
            where member_id = ?
        """;

        return template.queryForObject(sql, new MemberManagementRowMapper(), memberId);
    }

    @Override
    public void updateMember(Long memberId, MemberUpdateDTO memberUpdateDTO) {
        String sql = """
            update MEMBER
            set name = ?, email = ?, phone = ?
            where member_id = ?
        """;

        template.update(
            sql,
            memberUpdateDTO.getName(),
            memberUpdateDTO.getEmail(),
            memberUpdateDTO.getPhone(),
            memberId
        );
    }

    @Override
    public int countMembers() {
        String sql = "select count(*) from `MEMBER`";
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public List<MemberManagementDTO> findMembersWithPaging(int offset, int size) {
        String sql = "select member_id, login_id, name, email, phone, `role`, created_at "
                   + "from `MEMBER` "
                   + "order by member_id desc "
                   + "limit ? offset ?";

        return template.query(sql, new MemberManagementRowMapper(), size, offset);
    }
    @Override
    public void deleteMember(Long memberId) {
        String sql = "delete from MEMBER where member_id = ?";

        template.update(sql, memberId);
    }

    @Override
    public List<MemberManagementDTO> findMembersWithPagingAndKeyword(int offset, int size, String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            String sql = "select member_id, login_id, name, email, phone, role, created_at " +
                         "from MEMBER " +
                         "order by member_id desc " +
                         "limit ? offset ?";

            return template.query(sql, new MemberManagementRowMapper(), size, offset);
        }

        String searchKeyword = "%" + keyword.trim() + "%";

        String sql = "select member_id, login_id, name, email, phone, role, created_at " +
                     "from MEMBER " +
                     "where name like ? or login_id like ? " +
                     "order by member_id desc " +
                     "limit ? offset ?";

        return template.query(
                sql,
                new MemberManagementRowMapper(),
                searchKeyword,
                searchKeyword,
                size,
                offset
        );
    }

    @Override
    public int countMembersByKeyword(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            String sql = "select count(*) from MEMBER";
            return template.queryForObject(sql, Integer.class);
        }

        String searchKeyword = "%" + keyword.trim() + "%";

        String sql = "select count(*) from MEMBER " +
                     "where name like ? or login_id like ?";

        return template.queryForObject(
                sql,
                Integer.class,
                searchKeyword,
                searchKeyword
        );
    }
}