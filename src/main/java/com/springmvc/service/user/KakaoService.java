package com.springmvc.service.user;

import com.springmvc.dto.user.KakaoUserDTO;

public interface KakaoService {

    String getAccessToken(String code);
    
    KakaoUserDTO getKakaoUserInfo(String accessToken);
}