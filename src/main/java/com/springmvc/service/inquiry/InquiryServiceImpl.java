package com.springmvc.service.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.inquiry.InquiryDTO;
import com.springmvc.dto.inquiry.InquiryReplyDTO;
import com.springmvc.repository.inquiry.InquiryRepository;

@Service
public class InquiryServiceImpl implements InquiryService {
	
	
	@Autowired
    private InquiryRepository inquiryRepository;

	@Override
	public void saveInquiry(InquiryDTO inquiryDTO) {
		// TODO Auto-generated method stub
		inquiryRepository.saveInquiry(inquiryDTO);
	}

	@Override
	public List<InquiryDTO> findByMemberId(Long memberId) {
		// TODO Auto-generated method stub
		return inquiryRepository.findByMemberId(memberId);
	}

	@Override
	public InquiryDTO findByInquiryId(Long inquiryId) {
		// TODO Auto-generated method stub
		return inquiryRepository.findByInquiryId(inquiryId);
	}

	@Override
	public void saveReply(Long inquiryId, Long adminId, String content) {
		// TODO Auto-generated method stub
		inquiryRepository.saveReply(inquiryId, adminId, content);
	}

	@Override
	public List<InquiryReplyDTO> findRepliesByInquiryId(Long inquiryId) {
		// TODO Auto-generated method stub
		return inquiryRepository.findRepliesByInquiryId(inquiryId);
	}

	@Override
	public void updateInquiryStatus(Long inquiryId, String status) {
		// TODO Auto-generated method stub
		inquiryRepository.updateInquiryStatus(inquiryId, status);
	}

	@Override
	public void deleteInquiry(Long inquiryId) {
		// TODO Auto-generated method stub
		inquiryRepository.deleteInquiry(inquiryId);
	}

	@Override
	public List<InquiryDTO> findInquiriesWithPagingAndKeyword(int offset, int size, String keyword) {
		// TODO Auto-generated method stub
		return inquiryRepository.findInquiriesWithPagingAndKeyword(offset, size, keyword);
	}

	@Override
	public int countInquiriesByKeyword(String keyword) {
		// TODO Auto-generated method stub
		return inquiryRepository.countInquiriesByKeyword(keyword);
	}

    
}