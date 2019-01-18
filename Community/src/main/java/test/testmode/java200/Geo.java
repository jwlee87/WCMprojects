package test.testmode.java200;

public class Geo {
	
	private double latitude;
	private double longitute;

	public Geo() {
		// TODO Auto-generated constructor stub
	}
	public Geo(double latitude, double longitude) {
		this.latitude = latitude;
		this.longitute = longitude;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitute() {
		return longitute;
	}
	public void setLongitute(double longitute) {
		this.longitute = longitute;
	}

}
