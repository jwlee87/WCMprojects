package test.testmode;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class HttpClientTestSample {
	
	@Autowired
	private HttpClient httpClientPooling;
	private Logger logger = LogManager.getLogger();
	private int DEFAULT_TIMEOUT = 3000;

	public HttpClientTestSample() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value="/verify", method=RequestMethod.GET)
	public void testClientVerify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		RequestConfig defaultRequestConfig = RequestConfig.custom()
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setSocketTimeout(DEFAULT_TIMEOUT)
				.setConnectionRequestTimeout(DEFAULT_TIMEOUT)
				.build();
		String ipAddress = "211.110.139.185";
		HttpPost post = new HttpPost("http://"+ipAddress+"/api/verify-card-no");
		post.setConfig(defaultRequestConfig);
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cardno", "1040129038874600");
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(paramMap);
//			StringEntity entity = new StringEntity(jsonStr, ContentType.APPLICATION_FORM_URLENCODED);
		StringEntity entity = new StringEntity(jsonStr, "UTF-8");
		post.setEntity(entity);
		
		System.out.println("local 1");
		HttpResponse httpResponse = httpClientPooling.execute(post);
		System.out.println("local 2");
		
		int statusCode = httpResponse.getStatusLine().getStatusCode();
		logger.debug("===== statusCode ===== "+statusCode);
		
		System.out.println("local 3");
		String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
		System.out.println("local 4");
		System.out.println(body);
			
		HttpClientUtils.closeQuietly(httpResponse);
	}
	
	@RequestMapping(value="/complete", method=RequestMethod.GET)
	public void testClientComplete(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			RequestConfig defaultRequestConfig = RequestConfig.custom()
					.setConnectTimeout(DEFAULT_TIMEOUT)
					.setConnectTimeout(DEFAULT_TIMEOUT)
					.setSocketTimeout(DEFAULT_TIMEOUT)
					.setConnectionRequestTimeout(DEFAULT_TIMEOUT)
					.build();
			
			String ipAddress = "211.110.139.185";
			HttpPost post = new HttpPost("http://"+ipAddress+"/api/callback-commit-point");
			post.setConfig(defaultRequestConfig);
			
			JsonObject jso = new JsonObject();
			jso.addProperty("cardno", "1040129038874600");
			jso.addProperty("tid", "abcdefghij0987654321");
			jso.addProperty("amount", "50000");
			
			Gson gson = new Gson();
			String jsonStr = gson.toJson(jso);
//			StringEntity entity = new StringEntity(jsonStr, ContentType.APPLICATION_FORM_URLENCODED);
			StringEntity entity = new StringEntity(jsonStr, "UTF-8");
			post.setEntity(entity);
			
			System.out.println("local 1");
			HttpResponse httpResponse = httpClientPooling.execute(post);
			System.out.println("local 2");
			
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			logger.debug("===== statusCode ===== "+statusCode);
			System.out.println("local 3");
			String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
			System.out.println("local 4");
			System.out.println(body);
			
			HttpClientUtils.closeQuietly(httpResponse);
	}

}
