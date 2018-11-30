package test.testmode;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class LambdaTest {

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
	public void test() {
		
		Predicate<String> stringCompare = (String str) -> str.compareTo("abc")==0?true:false;
		System.out.println("Predicate test for abc="+ stringCompare.test("abc"));
		
	}
	
	@Test
	public void test2() {
		
		Function<String, Integer> intFunctionLambda = (String str) -> str.compareTo("abc")==0?1:0;
		System.out.println(intFunctionLambda.apply("abc"));
		System.out.println(intFunctionLambda.apply("ab"));
		
		Function<String, Float> floatFunctionLambda = (String str) -> str.compareTo("abc")==0?(float)1.0:(float)0.0;
		System.out.println(floatFunctionLambda.apply("abc"));
		System.out.println(floatFunctionLambda.apply("ab"));
		
		
	}

}
