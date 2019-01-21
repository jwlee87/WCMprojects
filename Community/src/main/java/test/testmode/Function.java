package test.testmode;

@FunctionalInterface
public interface Function<T, R> {
	R apply(T t);
}

/**
 * @author yizidev
 * @contents
 * 	첫번째 임의의 형태의 입력값을 받아 두번째 임의의 형태의 값으로 출력한다.
 * 	출력값의 형태를 자유자재로 지정할 수 있기 때문에, 상속을 통해 굉장히 다양하게 사용될 수 있는 람다
 * 	인터페이스이다.
 * 
 */
