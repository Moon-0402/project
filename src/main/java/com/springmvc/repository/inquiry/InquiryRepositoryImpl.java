package com.springmvc.repository.inquiry;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.dto.inquiry.InquiryDTO;
import com.springmvc.dto.inquiry.InquiryReplyDTO;

@Repository
public class InquiryRepositoryImpl implements InquiryRepository {

    private JdbcTemplate template;

    @Autowired
    public void setJdbcTemplate(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
    }

    @Override
    public void saveInquiry(InquiryDTO inquiryDTO) {
        String sql = """
            INSERT INTO INQUIRY
            (member_id, title, content, status, created_at)
            VALUES (?, ?, ?, 'WAITING', NOW())
        """;

        template.update(
            sql,
            inquiryDTO.getMemberId(),
            inquiryDTO.getTitle(),
            inquiryDTO.getContent()
        );
    }

    @Override
    public List<InquiryDTO> findByMemberId(Long memberId) {
        String sql = """
            SELECT
                i.inquiry_id,
                i.member_id,
                m.login_id,
                m.name,
                i.title,
                i.content,
                i.status,
                i.created_at
            FROM INQUIRY i
            JOIN MEMBER m ON i.member_id = m.member_id
            WHERE i.member_id = ?
            ORDER BY i.inquiry_id DESC
        """;

        return template.query(sql, new InquiryRowMapper(), memberId);
    }

    @Override
    public InquiryDTO findByInquiryId(Long inquiryId) {
        String sql = """
            SELECT
                i.inquiry_id,
                i.member_id,
                m.login_id,
                m.name,
                i.title,
                i.content,
                i.status,
                i.created_at
            FROM INQUIRY i
            JOIN MEMBER m ON i.member_id = m.member_id
            WHERE i.inquiry_id = ?
        """;

        return template.queryForObject(sql, new InquiryRowMapper(), inquiryId);
    }

    @Override
    public void saveReply(Long inquiryId, Long adminId, String content) {
        String sql = """
            INSERT INTO INQUIRY_REPLY
            (inquiry_id, admin_id, content, created_at)
            VALUES (?, ?, ?, NOW())
        """;

        template.update(sql, inquiryId, adminId, content);
    }

    @Override
    public List<InquiryReplyDTO> findRepliesByInquiryId(Long inquiryId) {
        String sql = """
            SELECT
                r.reply_id,
                r.inquiry_id,
                r.admin_id,
                m.login_id AS admin_login_id,
                m.name AS admin_name,
                r.content,
                r.created_at
            FROM INQUIRY_REPLY r
            JOIN MEMBER m ON r.admin_id = m.member_id
            WHERE r.inquiry_id = ?
            ORDER BY r.reply_id ASC
        """;

        return template.query(sql, new InquiryReplyRowMapper(), inquiryId);
    }

    @Override
    public void updateInquiryStatus(Long inquiryId, String status) {
        String sql = """
            UPDATE INQUIRY
            SET status = ?
            WHERE inquiry_id = ?
        """;

        template.update(sql, status, inquiryId);
    }

    @Override
    public void deleteInquiry(Long inquiryId) {
        String sql = "DELETE FROM INQUIRY WHERE inquiry_id = ?";
        template.update(sql, inquiryId);
    }

	//@Override
//	public List<InquiryDTO> findInquiriesWithPagingAndKeyword(int offset, int size, String keyword) {
//		// TODO Auto-generated method stub
//		if(keyword == null || keyword.trim().isEmpty()) {
//		String sql = "select * from INQUIRY order by inquiry_id asc limit ? offset ?";
//		return template.query(sql, new InquiryRowMapper(),size,offset);
//		}
//		
//		String searchKeyword = "%" + keyword.trim() +"%";
//		String sql = "select * from INQUIRY where member_id = ? or title = ? order by member_id desc limit ? offset ?";
//		return template.query(sql, new InquiryRowMapper(),searchKeyword,searchKeyword,size,offset);
//	}
    @Override
    public List<InquiryDTO> findInquiriesWithPagingAndKeyword(int offset, int size, String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {

            String sql = """
                SELECT
                    i.inquiry_id,
                    i.member_id,
                    m.login_id,
                    m.name,
                    i.title,
                    i.content,
                    i.status,
                    i.created_at
                FROM INQUIRY i
                JOIN MEMBER m ON i.member_id = m.member_id
                ORDER BY i.inquiry_id DESC
                LIMIT ? OFFSET ?
            """;

            return template.query(sql, new InquiryRowMapper(), size, offset);
        }

        String searchKeyword = "%" + keyword.trim() + "%";

        String sql = """
            SELECT
                i.inquiry_id,
                i.member_id,
                m.login_id,
                m.name,
                i.title,
                i.content,
                i.status,
                i.created_at
            FROM INQUIRY i
            JOIN MEMBER m ON i.member_id = m.member_id
            WHERE m.login_id LIKE ?
               OR m.name LIKE ?
            ORDER BY i.inquiry_id DESC
            LIMIT ? OFFSET ?
        """;

        return template.query(
                sql,
                new InquiryRowMapper(),
                searchKeyword,
                searchKeyword,
                size,
                offset
        );
    }
//	@Override
//	public int countInquiriesByKeyword(String keyword) {
//		// TODO Auto-generated method stub
//		if(keyword == null || keyword.trim().isEmpty()) {
//			String sql = "select count(*) from INQUIRY";
//			return template.queryForObject(sql, Integer.class);
//		}
//		String searchKeyword = "%" + keyword.trim() + "%";
//		String sql = "select count(*) from INQUIRY where member_id = ? or title = ?";
//		return template.queryForObject(sql, Integer.class,searchKeyword,searchKeyword);
//	}
    @Override
    public int countInquiriesByKeyword(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {

            String sql = """
                SELECT COUNT(*)
                FROM INQUIRY i
                JOIN MEMBER m ON i.member_id = m.member_id
            """;

            return template.queryForObject(sql, Integer.class);
        }

        String searchKeyword = "%" + keyword.trim() + "%";

        String sql = """
            SELECT COUNT(*)
            FROM INQUIRY i
            JOIN MEMBER m ON i.member_id = m.member_id
            WHERE m.login_id LIKE ?
               OR m.name LIKE ?
        """;

        return template.queryForObject(
                sql,
                Integer.class,
                searchKeyword,
                searchKeyword
        );
    }
    
}