package com.springmvc.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.admin.MemberManagementDTO;
import com.springmvc.dto.admin.MemberUpdateDTO;
import com.springmvc.repository.admin.AdminRepository;

@Service
public class AdminServiceImpl implements AdminService {

    private AdminRepository adminRepository;

    @Autowired
    public void setAdminRepository(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

    @Override
    public MemberManagementDTO findBymemberId(Long memberId) {
        return adminRepository.findBymemberId(memberId);
    }

    @Override
    public void updateMember(Long memberId, MemberUpdateDTO memberUpdateDTO) {
        adminRepository.updateMember(memberId, memberUpdateDTO);
    }

    @Override
    public List<MemberManagementDTO> findMembersWithPaging(int offset, int size) {
        return adminRepository.findMembersWithPaging(offset, size);
    }

    @Override
    public int countMembers() {
        return adminRepository.countMembers();
    }

    @Override
    public void deleteMember(Long memberId) {
        adminRepository.deleteMember(memberId);
    }

	@Override
	public List<MemberManagementDTO> findMembersWithPagingAndKeyword(int offset, int size, String keyword) {
		// TODO Auto-generated method stub
		return adminRepository.findMembersWithPagingAndKeyword(offset, size, keyword);
	}

	@Override
	public int countMembersByKeyword(String keyword) {
		// TODO Auto-generated method stub
		return adminRepository.countMembersByKeyword(keyword);
	}
}