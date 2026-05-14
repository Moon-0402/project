package com.springmvc.repository.member;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.dto.user.FindIdDTO;
import com.springmvc.dto.user.FindPwDTO;
import com.springmvc.dto.user.LoginDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.dto.user.PwChangeDTO;
import com.springmvc.dto.user.SignupDTO;

public interface MemberRepository {
	
    // 로그인
    LoginMemberDTO login(LoginDTO loginDTO);
	
    // 회원가입
    void signup(SignupDTO signupDTO);

    int countById(String id);

    int countByEmail(String email);

    // 아이디찾기
    String findId(FindIdDTO findIdDTO);

    // 비밀번호 찾기
    String findPw(FindPwDTO findPwDTO);

    // 비번 변경
    void changePassword(String loginId, PwChangeDTO pwChangeDTO);
    
    // 마이페이지 정보 수정
    void updateMyInfo(Long memberId, MemberUpdateDTO memberUpdateDTO);
    
    MemberManagementDTO findBymemberId(Long memberId);

    // 마이페이지 비밀번호 변경에서 현재 비밀번호 확인용
    String findPasswordByLoginId(String loginId);
    
    MemberManagementDTO findByLoginId(String loginId);

    void insertKakaoMember(String loginId, String password, String name, String email);

    LoginMemberDTO findLoginMemberByLoginId(String loginId);
}