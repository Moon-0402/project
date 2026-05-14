package com.springmvc.repository.admin;

import java.util.List;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;

public interface AdminRepository {

    // 회원 상세 조회
    MemberManagementDTO findBymemberId(Long memberId);

    // 회원 정보 수정
    void updateMember(Long memberId, MemberUpdateDTO memberUpdateDTO);

    // 페이징 회원 조회
    List<MemberManagementDTO> findMembersWithPaging(int offset, int size);

    // 전체 회원 수 조회
    int countMembers();

    // 검색 + 페이징 회원 조회
    List<MemberManagementDTO> findMembersWithPagingAndKeyword(int offset, int size, String keyword);

    // 검색 결과 회원 수 조회
    int countMembersByKeyword(String keyword);

    // 회원 삭제
    void deleteMember(Long memberId);

}