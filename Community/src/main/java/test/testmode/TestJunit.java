package test.testmode;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.nhncorp.lucy.security.xss.XssPreventer;

import junit.framework.Assert;

public class TestJunit {

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
		String dirty = "\"><script>alert('xss');</script>";
		String clean = XssPreventer.escape(dirty);
		
		Assert.assertEquals(clean, "&quot;&gt;&lt;script&gt;alert(&#39;xss&#39;);&lt;/script&gt;");
		Assert.assertEquals(dirty, XssPreventer.unescape(clean));
	}

}
