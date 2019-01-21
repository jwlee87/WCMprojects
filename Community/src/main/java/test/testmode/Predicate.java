package test.testmode;

@FunctionalInterface
public interface Predicate<T> {
	boolean test(T t);
}

/**
 * @author wonnana
 * @contents
 *   임의의 타입 T 형태의 객체입력을 받아 그 값이 true인지 false 인지를 리턴한다.
 *   
 */
