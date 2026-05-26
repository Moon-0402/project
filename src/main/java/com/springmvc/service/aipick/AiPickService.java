package com.springmvc.service.aipick;

import java.util.List;

import com.springmvc.dto.aipick.AiPickDTO;

public interface AiPickService {

    // 최종 AI PICK 결과 반환
    List<AiPickDTO> getAiPickList(Long memberId, Double lat, Double lng);

}