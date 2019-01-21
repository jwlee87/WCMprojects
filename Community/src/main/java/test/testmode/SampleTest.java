package test.testmode;

public class SampleTest {

	public SampleTest() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		/**
		 * switch문의 활용
		 */
		/*
		char c = 'A';
		int tot = 0;
		
	    switch(c){
	        case 'A': tot=1;break;
	        case 'T': tot=10;break;
	        case 'J': tot=11;break;
	        case 'Q': tot=12;break;
	        case 'K': tot=13;break;
	        default: tot=c-'0';break;
	    }
	    
	    System.out.println(tot);
		
	    System.out.println((int)'9'-(int)'0');
	    System.out.println('9'-'0');
	    */
		
		/**
		 * 2345 각 자리의 수의 합
		 */
		/*
		int n = 2345;
		int tot=0;
		for( ;n>0; ) {
			tot=tot+n%10;
			n=n/10;
		}
	    System.out.println(tot);
	    */
		
		/**
		 * 10의 약수 구하기
		 */
		/*
		int n = 10;
		System.out.print("[1, ");
		for(int i = 2; i < n; i++) {
			if(n%i == 0) {
				System.out.printf("%d, ", i);
			}
		}
		System.out.println(n+"]");
		*/
		
		/*
		Sample sample = new Sample();
		System.out.println(sample.phyval);
		*/
	}
}

