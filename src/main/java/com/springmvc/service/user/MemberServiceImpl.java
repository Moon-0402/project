package com.springmvc.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.dto.user.FindIdDTO;
import com.springmvc.dto.user.FindPwDTO;
import com.springmvc.dto.user.KakaoUserDTO;
import com.springmvc.dto.user.LoginDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.dto.user.PwChangeDTO;
import com.springmvc.dto.user.SignupDTO;
import com.springmvc.repository.member.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberRepository memberRepository;
	
	
	@Override
	public LoginMemberDTO login(LoginDTO loginDTO) {
		// TODO Auto-generated method stub
		return memberRepository.login(loginDTO);
	}

	@Override
	public void signup(SignupDTO signupDTO) {
		// TODO Auto-generated method stub
		memberRepository.signup(signupDTO);
	}

	@Override
	public String findId(FindIdDTO findIdDTO) {
		// TODO Auto-generated method stub
		return memberRepository.findId(findIdDTO);
	}

	@Override
	public String findPw(FindPwDTO findPwDTO) {
		// TODO Auto-generated method stub
		return memberRepository.findPw(findPwDTO);
	}

	@Override
	public void changePassword(String loginId, PwChangeDTO pwChangeDTO) {
		// TODO Auto-generated method stub
		memberRepository.changePassword(loginId, pwChangeDTO);
	}


	@Override
	public int countById(String id) {
		// TODO Auto-generated method stub
		return memberRepository.countById(id);
	}

	@Override
	public int countByEmail(String email) {
		// TODO Auto-generated method stub
		return memberRepository.countByEmail(email);
	}

	@Override
	public void updateMyInfo(Long memberId, MemberUpdateDTO memberUpdateDTO) {
		// TODO Auto-generated method stub
		memberRepository.updateMyInfo(memberId, memberUpdateDTO);
	}

	@Override
	public MemberManagementDTO findBymemberId(Long memberId) {
		// TODO Auto-generated method stub
		return memberRepository.findBymemberId(memberId);
	}

	@Override
	public String findPasswordByLoginId(String loginId) {
		// TODO Auto-generated method stub
		return memberRepository.findPasswordByLoginId(loginId);
	}
	
	@Override
	public LoginMemberDTO kakaoLogin(KakaoUserDTO kakaoUser) {

	    String loginId = "kakao_" + kakaoUser.getKakaoId();

	    LoginMemberDTO loginMember = memberRepository.findLoginMemberByLoginId(loginId);

	    if (loginMember != null) {
	        return loginMember;
	    }

	    String password = "KAKAO_LOGIN";
	    String name = "카카오회원" + kakaoUser.getKakaoId();
	    String email = loginId + "@kakao.local";

	    memberRepository.insertKakaoMember(loginId, password, name, email);

	    return memberRepository.findLoginMemberByLoginId(loginId);
	}
}
