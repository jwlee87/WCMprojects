package test.testmode;

import java.util.Map;

import org.json.simple.JSONObject;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

public class JsonBenchmark {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void gsonTest() {
		String jsonStr = "[{ \"\"id \":\"1318403074887 \",\"orign \":\"xxx.jpg \",\"ow \": 427,\"small \":\"xxx.jpg \",\"middle \":\"xxx .jpg \",\"오 \": 640}, {\"id \":\"1318403076793 \",\"orign \":\"xxx.jpg \",\"ow \": 640,\"small \":\"xxx.jpg \",\"middle \" \"xxx.jpg\", \"oh\": 480}, { \"id\": \"1318403092168\", \"orign\": \"xxx.jpg\", \"ow\": 425, \"small\": \"xxx.jpg\", \"middle \":\"xxx.jpg \",\"oh \": 640}]";
		Gson gson = new Gson();
		JsonElement je = gson.toJsonTree(jsonStr);
		JsonArray ja = (JsonArray) gson.toJsonTree(je, getClass());
		System.out.println("isJsonArray? "+je.isJsonArray());
		System.out.println("isJsonNull? "+je.isJsonNull());
		System.out.println("hashCode "+je.hashCode());
		System.out.println(je);
	}
	
//	@Test
	public void jacksonTest() {
		
		JSONObject aa = new JSONObject();
	}

}
