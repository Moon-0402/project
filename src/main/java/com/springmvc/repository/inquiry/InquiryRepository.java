package com.springmvc.repository.inquiry;

import java.util.List;

import com.springmvc.dto.inquiry.InquiryDTO;
import com.springmvc.dto.inquiry.InquiryReplyDTO;

public interface InquiryRepository {

    void saveInquiry(InquiryDTO inquiryDTO);

    List<InquiryDTO> findByMemberId(Long memberId);

    InquiryDTO findByInquiryId(Long inquiryId);

    void saveReply(Long inquiryId, Long adminId, String content);

    List<InquiryReplyDTO> findRepliesByInquiryId(Long inquiryId);

    void updateInquiryStatus(Long inquiryId, String status);

    void deleteInquiry(Long inquiryId);
    
    //화면에 보여줄 목록
    List<InquiryDTO> findInquiriesWithPagingAndKeyword(int offset, int size, String keyword);
    
    //페이지 번호
    int countInquiriesByKeyword(String keyword);
}