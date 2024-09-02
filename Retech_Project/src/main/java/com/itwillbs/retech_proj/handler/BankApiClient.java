package com.itwillbs.retech_proj.handler;

import java.net.URI;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.JsonObject;
import com.itwillbs.retech_proj.vo.BankToken;

@Component
public class BankApiClient {
	// 오픈뱅킹 API 요청 시 사용할 데이터를 별도의 외부 파일로 분리하여 관리
	// => src/main/resources/config/appdata.properties 파일 생성 후 속성=값 형식으로 값 저장
	// => 주의! 해당 파일을 스프링 클래스 내에서 접근하려면 servlet-context.xml 파일 내에 설정 필수!
	// @Value("${속성값 저장된 파일 내의 속성명}") 형태로 지정하고 변수 선언하면 자동 저장됨
	@Value("${client_id}")
	private String client_id;
	
	@Value("${client_secret}")
	private String client_secret;
	
	@Value("${redirect_uri}")
	private String redirect_uri;
	
	@Value("${client_use_code}")
	private String client_use_code;
	
	@Value("${cntr_account_num}")
	private String cntr_account_num;
	
	@Value("${cntr_account_holder_name}")
	private String cntr_account_holder_name;
	
	@Value("${base_url}")
	private String base_url;
	
	@Autowired
	private BankValueGenerator bankValueGenerator;

	// 로깅을 위한 Logger 타입 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(BankApiClient.class);
	
	// ------------------------------------------------------------------------------------
	// 2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged)
	public BankToken requestAccessToken(Map<String, String> authResponse) {
		// 금융결제원 오픈API 토큰 발급 API 요청 작업 수행 및 결과 처리
		URI uri = UriComponentsBuilder
					.fromUriString(base_url + "/oauth/2.0/token") // 요청 주소 설정
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		
		// POST 방식 요청 수행 시 파라미터를 URL 에 결합하는 대신 body 에 별도로 포함시켜야 함
		// 해당 파라미터 데이터를 별도의 객체를 통해 전달 =>  LinkedMultiValueMap 타입 객체 활용
		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		
		parameters.add("code", authResponse.get("code"));
		parameters.add("client_id", client_id);
		parameters.add("client_secret", client_secret);
		parameters.add("redirect_uri", redirect_uri);
		parameters.add("grant_type", "authorization_code");
		
		// 요청 정보로 사용할 헤더와 바디 정보를 관리하는 HttpEntity 타입 객체 생성
		// => 제네릭타입으로 파라미터를 관리하는 객체 타입(LinkedMultiValueMap) 지정 후
		//    생성자에 해당 제네릭 타입에 대한 객체 전달(POST 방식 요청에 대한 설정)
		// => 헤더 정보는 별도의 추가 작업이 불필요하므로 설정 생략
		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = 
				new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);
		
		// REST API(RESTful API) 요청을 위해 RestTemplate 객체 활용
		RestTemplate restTemplate = new RestTemplate();
		// 4-2) RestTemplate 객체의 exchange() 메서드 호출하여 요청 수행
		// => 파라미터 : 요청 URL 관리하는 객체(URI)
		//               요청 메서드(HttpMethod.XXX 상수 활용. POST 방식이므로 HttpMethod.POST 사용)
		//               요청 정보를 관리하는 HttpEntity 객체
		//               요청에 대한 응답 전달되면 응답 데이터를 파싱하여 관리할 클래스
		//               (주의! JSON 타입 응답데이터 자동 파싱을 위해 Gson, Jackson 등 라이브러리 필수!)
		// 응답 데이터를 VO 클래스 타입으로 파싱할 경우
		// => 마지막 파라미터를 파싱에 사용할 클래스를 전달하고
		//    리턴되는 객체를 ResponseEntity<T> 타입으로 전달받기
		//    (이 때, 제네릭타입 T 는 마지막 파라미터로 지정한 클래스명 사용)
		ResponseEntity<BankToken> responseEntity = restTemplate.exchange(
				uri, // 요청 URL 관리하는 URI 타입 객체(문자열로 된 URL 도 전달 가능)
				HttpMethod.POST, // 요청 메서드(HttpMethod.XXX 상수 활용)
				httpEntity, // 요청 정보를 관리하는 HttpEntity 객체
				BankToken.class); // 응답 데이터 파싱하여 관리할 클래스(.class 필수!)
		// 주의! 응답 데이터인 JSON 타입 데이터를 BankToken 타입으로 자동 파싱하려면
		// Gson 또는 Jackson 라이브러리가 필요한데 이 라이브러리가 없을 경우
		// 자동 파싱이 불가능하므로 실행 시 예외 발생!
		// org.springframework.web.client.UnknownContentTypeException: Could not extract response: no suitable HttpMessageConverter found for response type [class com.itwillbs.mvc_board.vo.BankToken] and content type [application/json;charset=UTF-8]
		
		// 임시) 응답 정보 확인을 위해 ResponseEntity 객체의 메서드 활용
		logger.info("응답 코드 : " + responseEntity.getStatusCode());
		logger.info("응답 헤더 : " + responseEntity.getHeaders());
		logger.info("응답 본문 : " + responseEntity.getBody());
		
		// 5. 응답 정보 리턴
		// => ResponseEntity 객체를 직접 리턴하지 않고 getBody() 메서드 호출 결과인
		//    파싱 정보를 관리하는 객체를 리턴
		return responseEntity.getBody();
	}

	// 2.2.3. 등록계좌조회 API 
	public Map<String, Object> requestAccountList(BankToken token) {
		// 1. HTTP 요청에 필요한 URI 정보 관리할 URI 객체 생성
		URI uri = UriComponentsBuilder	
					.fromUriString(base_url)
					.path("/v2.0/account/list")
					.queryParam("user_seq_no", token.getUser_seq_no())
					.queryParam("include_cancel_yn", "Y")
					.queryParam("D")
					.encode()
					.build()
					.toUri();
		
		// 2. API 요청 헤더정보 관리할 HttpHeaders 객체 생성
		HttpHeaders headers = new HttpHeaders();
		// 헤더정보에 액세스 토큰값 설정
		headers.setBearerAuth(token.getAccess_token());
		
		// 3. 헤더와 바디를 묶어서 관리하는 HttpEntity 객체 생성, HttpHeaders 객체 전달
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		
		// 4. RESTful API 요청을 위한 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		// exchange 메서드 호출하여 HTTP(REST API) 요청 수행
		ParameterizedTypeReference<Map<String, Object>> responseType = new ParameterizedTypeReference<Map<String,Object>>() {};
		ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(uri, HttpMethod.GET, httpEntity, responseType);
	
		return responseEntity.getBody();
	}

	// 2.2.1. 사용자정보조회 API
	public Map<String, Object> requestUserInfo(BankToken token) {
		// 1. HTTP 요청에 필요한 URI 정보 관리할 URI 객체 생성
		URI uri = UriComponentsBuilder	
					.fromUriString(base_url)
					.path("/v2.0/user/me")
					.queryParam("user_seq_no", token.getUser_seq_no())
					.encode()
					.build()
					.toUri();
		
		// 2. API 요청 헤더정보 관리할 HttpHeaders 객체 생성
		HttpHeaders headers = new HttpHeaders();
		// 헤더정보에 액세스 토큰값 설정
		headers.setBearerAuth(token.getAccess_token());
		
		// 3. 헤더와 바디를 묶어서 관리하는 HttpEntity 객체 생성, HttpHeaders 객체 전달
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		
		// 4. RESTful API 요청을 위한 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		// exchange 메서드 호출하여 HTTP(REST API) 요청 수행
		ParameterizedTypeReference<Map<String, Object>> responseType = new ParameterizedTypeReference<Map<String,Object>>() {};
		ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(uri, HttpMethod.GET, httpEntity, responseType);
	
		return responseEntity.getBody();		
	}

	// 2.5.1. 출금이체 API
	public Map<String, String> requestWithdraw(Map<String, Object> map) {
		BankToken token = (BankToken)map.get("token");
		String id = (String)map.get("id");
		
		// 요청에 사용될 bank_tran_id, tran_dtime 값 생성
		String bank_tran_id = bankValueGenerator.getBankTranId(client_use_code);
		String tran_dtime = bankValueGenerator.getTranDTime();
		
		// 1. HTTP 요청에 필요한 URI 정보 관리할 URI 객체 생성
		URI uri = UriComponentsBuilder	
				.fromUriString(base_url)
				.path("/v2.0/transfer/withdraw/fin_num")
				.queryParam("user_seq_no", token.getUser_seq_no())
				.encode()
				.build()
				.toUri();
		
		// 2. API 요청 헤더정보 관리할 HttpHeaders 객체 생성
		HttpHeaders headers = new HttpHeaders();
		// 헤더정보에 액세스 토큰값 설정
		headers.setBearerAuth(token.getAccess_token());
		// 전송 요청 타입이 "application/json; charset=UTF-8"이므로 HttpHeaders 객체를 JSON 타입으로 설정
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		// 3. 요청 파라미터를 JSON 형식 데이터로 생성
		JsonObject jsonObject = new JsonObject();
		
		// ----- 핀테크 이용기관 정보 -----
		jsonObject.addProperty("bank_tran_id", bank_tran_id);
		jsonObject.addProperty("cntr_account_type", "N");
		jsonObject.addProperty("cntr_account_num", cntr_account_num);
		jsonObject.addProperty("dps_print_content", id.substring(0, 7));
		
		// ----- 요청 고객(출금계좌) 정보 -----
		jsonObject.addProperty("fintech_use_num", (String)map.get("withdraw_fintech_use_num"));
		jsonObject.addProperty("wd_print_content", "리테크_입금");
		jsonObject.addProperty("tran_amt", (String)map.get("tran_amt"));
		jsonObject.addProperty("tran_dtime", tran_dtime);
		jsonObject.addProperty("req_client_name", (String)map.get("withdraw_client_name"));
		jsonObject.addProperty("req_client_fintech_use_num", (String)map.get("withdraw_fintech_use_num"));
		jsonObject.addProperty("req_client_num", "YOU1004");
		jsonObject.addProperty("transfer_purpose", "ST");
		
		// ----- 수취 고객(실제 최종 입금 대상) 정보 -----
		jsonObject.addProperty("recv_client_name", cntr_account_holder_name);
		jsonObject.addProperty("recv_client_bank_code", "002");
		jsonObject.addProperty("recv_client_account_num", cntr_account_num);
		
		System.out.println("-------------------jsonObject : " + jsonObject.toString());
		
		
		// 4. 헤더와 바디를 묶어서 관리하는 HttpEntity 객체 생성
		HttpEntity<String> httpEntity = new HttpEntity<String>(jsonObject.toString(), headers);
		
		// 5. RESTful API 요청을 위한 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		// exchange 메서드 호출하여 HTTP(REST API) 요청 수행
		ParameterizedTypeReference<Map<String, String>> responseType = new ParameterizedTypeReference<Map<String,String>>() {};
		ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(uri, HttpMethod.POST, httpEntity, responseType);
		
		return responseEntity.getBody();		
	}
	

}
	











