package test.testmode;

public interface Consumer<T> {
	void accept(T t);
}

/**
 * @contents
 * 임의 형태의 입력값을 받고, 출력은 하지 않는 형태의 인터페이스이다. 대표적으로 사용되는 곳은
 * Collection.sort 명령의 인자값이다.
 */
