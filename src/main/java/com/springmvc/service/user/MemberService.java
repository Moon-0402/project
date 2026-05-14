package com.springmvc.service.user;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.dto.user.FindIdDTO;
import com.springmvc.dto.user.FindPwDTO;
import com.springmvc.dto.user.KakaoUserDTO;
import com.springmvc.dto.user.LoginDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.dto.user.PwChangeDTO;
import com.springmvc.dto.user.SignupDTO;

public interface MemberService {

    LoginMemberDTO login(LoginDTO loginDTO);

    void signup(SignupDTO signupDTO);

    int countById(String id);

    int countByEmail(String email);

    String findId(FindIdDTO findIdDTO);

    String findPw(FindPwDTO findPwDTO);

    void changePassword(String loginId, PwChangeDTO pwChangeDTO);

    void updateMyInfo(Long memberId, MemberUpdateDTO memberUpdateDTO);

    MemberManagementDTO findBymemberId(Long memberId);

    String findPasswordByLoginId(String loginId);
    
    LoginMemberDTO kakaoLogin(KakaoUserDTO kakaoUser);
}