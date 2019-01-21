package test.testmode;

public class Sample {

	double phyval = getBioRhythmValue(16649, 23, 100);

	public static double getBioRhythmValue(long days, int index, int max) {
	    return max * Math.sin((days % index) * 2 * 3.14 / index);
	}

}
