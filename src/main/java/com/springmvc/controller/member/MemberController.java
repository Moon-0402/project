package com.springmvc.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.dto.user.FindIdDTO;
import com.springmvc.dto.user.FindPwDTO;
import com.springmvc.dto.user.LoginDTO;
import com.springmvc.dto.user.LoginMemberDTO;
import com.springmvc.dto.user.MyPwChangeDTO;
import com.springmvc.dto.user.PwChangeDTO;
import com.springmvc.dto.user.SignupDTO;
import com.springmvc.service.user.KakaoService;
import com.springmvc.service.user.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@GetMapping("/login")
	public String loginForm(Model model) {
		model.addAttribute("loginDTO", new LoginDTO());
		return "member/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute LoginDTO loginDTO, HttpSession session, RedirectAttributes rttr) {

		LoginMemberDTO loginMember = memberService.login(loginDTO);

		if (loginMember == null) {
			rttr.addFlashAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/login";
		}

		session.setAttribute("loginMember", loginMember);

		if ("ADMIN".equals(loginMember.getRole())) {
			return "redirect:/admin";
		}

		return "redirect:/";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/signup")
	public String signupForm(Model model) {
		model.addAttribute("signupDTO", new SignupDTO());
		return "member/signup";
	}

	@PostMapping("/signup")
	public String signup(@ModelAttribute SignupDTO signupDTO, RedirectAttributes rttr) {
		// 아이디 중복 확인
		if (memberService.countById(signupDTO.getId()) > 0) {
			rttr.addFlashAttribute("errorMessage", "이미 사용 중인 아이디입니다.");
			return "redirect:/member/signup";
		}

		// 이메일 중복 확인
		if (memberService.countByEmail(signupDTO.getEmail()) > 0) {
			rttr.addFlashAttribute("errorMessage", "이미 사용 중인 이메일입니다.");
			return "redirect:/member/signup";
		}

		// 비밀번호 확인
		if (signupDTO.getPw() == null || signupDTO.getPw().trim().isEmpty()) {
			rttr.addFlashAttribute("errorMessage", "비밀번호를 입력해주세요.");
			return "redirect:/member/signup";
		}

		if (!signupDTO.getPw().equals(signupDTO.getPwCheck())) {
			rttr.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/member/signup";
		}

		// 약관 동의 확인
		if (!signupDTO.isTermsAgree()) {
			rttr.addFlashAttribute("errorMessage", "약관에 동의해주세요.");
			return "redirect:/member/signup";
		}

		memberService.signup(signupDTO);

		rttr.addFlashAttribute("successMessage", "회원가입이 완료되었습니다. 로그인해주세요.");

		return "redirect:/member/login";
	}

	@GetMapping("/findId")
	public String findIdForm(Model model) {
		model.addAttribute("findIdDTO", new FindIdDTO());
		return "member/findId";
	}

	@PostMapping("/findId")
	public String findId(@ModelAttribute FindIdDTO findIdDTO, RedirectAttributes rttr) {

		String foundId = memberService.findId(findIdDTO);

		if (foundId == null || foundId.isEmpty()) {
			rttr.addFlashAttribute("errorMessage", "일치하는 회원 정보를 찾을 수 없습니다.");
			return "redirect:/member/findId";
		}

		rttr.addFlashAttribute("foundId", foundId);
		return "redirect:/member/findId";
	}

	@GetMapping("/findPw")
	public String findPwForm(Model model) {
		model.addAttribute("findPwDTO", new FindPwDTO());
		return "member/findPw";
	}

	@PostMapping("/findPw")
	public String findPw(@ModelAttribute FindPwDTO findPwDTO, HttpSession session, RedirectAttributes rttr) {

		String loginId = memberService.findPw(findPwDTO);

		if (loginId == null || loginId.isEmpty()) {
			rttr.addFlashAttribute("errorMessage", "일치하는 회원 정보를 찾을 수 없습니다.");
			return "redirect:/member/findPw";
		}

		session.setAttribute("pwResetLoginId", loginId);

		return "redirect:/member/changePw";
	}

	@GetMapping("/changePw")
	public String changePwForm(HttpSession session, Model model, RedirectAttributes rttr) {

		String loginId = (String) session.getAttribute("pwResetLoginId");

		if (loginId == null) {
			rttr.addFlashAttribute("errorMessage", "비밀번호 찾기 인증을 먼저 해주세요.");
			return "redirect:/member/findPw";
		}

		model.addAttribute("pwChangeDTO", new PwChangeDTO());
		return "member/changePw";
	}

	@PostMapping("/changePw")
	public String changePw(@ModelAttribute PwChangeDTO pwChangeDTO, HttpSession session, RedirectAttributes rttr) {

		String loginId = (String) session.getAttribute("pwResetLoginId");

		if (loginId == null) {
			rttr.addFlashAttribute("errorMessage", "비밀번호 찾기 인증을 먼저 진행해주세요.");
			return "redirect:/member/findPw";
		}

		if (pwChangeDTO.getPw() == null || pwChangeDTO.getPw().trim().isEmpty()) {
			rttr.addFlashAttribute("errorMessage", "새 비밀번호를 입력해주세요.");
			return "redirect:/member/changePw";
		}

		if (!pwChangeDTO.getPw().equals(pwChangeDTO.getPwCheck())) {
			rttr.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/member/changePw";
		}

		memberService.changePassword(loginId, pwChangeDTO);

		session.removeAttribute("pwResetLoginId");

		rttr.addFlashAttribute("successMessage", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
		return "redirect:/member/login";
	}

	@GetMapping("/mypage")
	public String updateMemberForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/member/login";
		}

		MemberManagementDTO member = memberService.findBymemberId(loginMember.getMemberId());

		model.addAttribute("member", member);

		return "member/mypage";
	}

	@PostMapping("/mypage")
	public String updateMember(@ModelAttribute MemberUpdateDTO memberUpdateDTO, HttpSession session,
			RedirectAttributes redirectAttributes) {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/member/login";
		}

		memberService.updateMyInfo(loginMember.getMemberId(), memberUpdateDTO);

		redirectAttributes.addFlashAttribute("msg", "회원 정보가 수정되었습니다.");

		return "redirect:/member/mypage";
	}

	// 마이페이지 비밀번호 변경 페이지 이동
	@GetMapping("/mypage/changePw")
	public String mypageChangePwForm(HttpSession session, Model model, RedirectAttributes rttr) {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			rttr.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/member/login";
		}

		model.addAttribute("myPwChangeDTO", new MyPwChangeDTO());

		return "member/mypageChangePw";
	}

	// 마이페이지 비밀번호 변경 처리
	@PostMapping("/mypage/changePw")
	public String mypageChangePw(@ModelAttribute MyPwChangeDTO myPwChangeDTO, HttpSession session,
			RedirectAttributes rttr) {

		LoginMemberDTO loginMember = (LoginMemberDTO) session.getAttribute("loginMember");

		if (loginMember == null) {
			rttr.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/member/login";
		}

		String loginId = loginMember.getLoginId();

		if (myPwChangeDTO.getCurrentPw() == null || myPwChangeDTO.getCurrentPw().trim().isEmpty()) {
			rttr.addFlashAttribute("errorMessage", "현재 비밀번호를 입력해주세요.");
			return "redirect:/member/mypage/changePw";
		}

		if (myPwChangeDTO.getNewPw() == null || myPwChangeDTO.getNewPw().trim().isEmpty()) {
			rttr.addFlashAttribute("errorMessage", "새 비밀번호를 입력해주세요.");
			return "redirect:/member/mypage/changePw";
		}

		if (!myPwChangeDTO.getNewPw().equals(myPwChangeDTO.getNewPwCheck())) {
			rttr.addFlashAttribute("errorMessage", "새 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/mypage/changePw";
		}

		String dbPassword = memberService.findPasswordByLoginId(loginId);

		if (!myPwChangeDTO.getCurrentPw().equals(dbPassword)) {
			rttr.addFlashAttribute("errorMessage", "현재 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/mypage/changePw";
		}

		PwChangeDTO pwChangeDTO = new PwChangeDTO();
		pwChangeDTO.setPw(myPwChangeDTO.getNewPw());
		pwChangeDTO.setPwCheck(myPwChangeDTO.getNewPwCheck());

		memberService.changePassword(loginId, pwChangeDTO);

		rttr.addFlashAttribute("successMessage", "비밀번호가 변경되었습니다.");

		return "redirect:/member/mypage/changePw";
	}

	
}