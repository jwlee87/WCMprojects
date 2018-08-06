package test.testmode;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

public class SimpleServerTest {

	public SimpleServerTest() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		
		SimpleServerTest ss = new SimpleServerTest();
	}
	
	public void ServerRun() throws IOException {
		
		ServerSocket server = null;
		int port = 4200;
		Socket socket = null;
		
		InputStream is = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		
//		try {
//			
//		}
	}

}
