package test.testmode.java200;

import test.testmode.java200.Geo;

public class GeoMain {
	
	public static void main(String[] args) {
	    Geo seoul = new Geo(37.5670, 126.9807);
	    Geo austria = new Geo(47.01, 10.2);
	    Geo newyork = new Geo(40.714086, -74.228697);
	    Geo mexico = new Geo(19.42847, -99.12766);
	    Geo china = new Geo(39.9075, 116.39723);
	    Geo rusia = new Geo(55.75222, 37.61556);
	
	    showGeo(seoul, seoul, newyork);
	    System.out.println("===");
	    
	    showGeo(seoul, seoul, newyork, mexico, china, rusia);
	    System.out.println("===");
	    
	    Geo[] geoArray = new Geo[] {seoul, austria, newyork, mexico, china, rusia};
	    showGeoArray(geoArray);
	    System.out.println("===");

	    geoArray = new Geo[3];
	    geoArray[0] = rusia;
	    geoArray[1] = seoul;
	    geoArray[2] = china;
	    showGeoArray(geoArray);
	    System.out.println("===");
	}
	
	public static void showGeo(Geo ...goose){
	    for(Geo gg:goose){
	    	System.out.printf("위도: %f, 경도: %f\n", gg.getLatitude(), gg.getLongitute());
	    }
	}
	
	public static void showGeoArray(Geo[] args){
	    for(Geo gg: args){
	    	System.out.printf("위도: %f, 경도: %f\n", gg.getLatitude(), gg.getLongitute());
	    }
	}
}

