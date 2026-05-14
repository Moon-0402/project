package com.springmvc.service.user;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springmvc.dto.user.KakaoUserDTO;

@Service
public class KakaoServiceImpl implements KakaoService {

    private final String REST_API_KEY = "bb90d370055218fddaec7cd1d7044494";
    private final String REDIRECT_URI = "http://localhost:8080/AppProject01/member/kakao/callback";
    private final String CLIENT_SECRET = "IQceBe7icxQl3J6HVQVXVKlXhvp3q8EX";

    @Override
    public String getAccessToken(String code) {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", REST_API_KEY);
        params.add("redirect_uri", REDIRECT_URI);
        params.add("code", code);

        // 클라이언트 시크릿을 카카오에서 ON 해놨으면 필요
        params.add("client_secret", CLIENT_SECRET);

        HttpEntity<MultiValueMap<String, String>> request =
                new HttpEntity<MultiValueMap<String, String>>(params, headers);

        try {
            ResponseEntity<String> response =
                    restTemplate.postForEntity(tokenUrl, request, String.class);

            System.out.println("카카오 토큰 응답: " + response.getBody());

            ObjectMapper objectMapper = new ObjectMapper();

            Map<String, Object> result =
                    objectMapper.readValue(response.getBody(), Map.class);

            return (String) result.get("access_token");

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("카카오 access token 요청 실패", e);
        }
    }

    @Override
    public KakaoUserDTO getKakaoUserInfo(String accessToken) {
        String userInfoUrl = "https://kapi.kakao.com/v2/user/me";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<String> request = new HttpEntity<String>(headers);

        try {
            ResponseEntity<String> response =
                    restTemplate.postForEntity(userInfoUrl, request, String.class);

            System.out.println("카카오 사용자 정보 응답: " + response.getBody());

            ObjectMapper objectMapper = new ObjectMapper();

            Map<String, Object> result =
                    objectMapper.readValue(response.getBody(), Map.class);

            Long kakaoId = Long.valueOf(String.valueOf(result.get("id")));

            Map<String, Object> kakaoAccount =
                    (Map<String, Object>) result.get("kakao_account");

            String email = null;

            if (kakaoAccount != null && kakaoAccount.get("email") != null) {
                email = String.valueOf(kakaoAccount.get("email"));
            }

            Map<String, Object> properties =
                    (Map<String, Object>) result.get("properties");

            String nickname = null;

            if (properties != null && properties.get("nickname") != null) {
                nickname = String.valueOf(properties.get("nickname"));
            }

            KakaoUserDTO kakaoUser = new KakaoUserDTO();
            kakaoUser.setKakaoId(kakaoId);
            kakaoUser.setEmail(email);
            kakaoUser.setNickname(nickname);

            return kakaoUser;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("카카오 사용자 정보 요청 실패", e);
        }
    }
}