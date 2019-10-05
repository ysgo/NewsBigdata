package vo;

import com.opencsv.bean.CsvBindByPosition;

public class ProvinceVO {
	@CsvBindByPosition(position=0)
	private int p_code;
	@CsvBindByPosition(position=1)
	private String name;
	@CsvBindByPosition(position=2)
	private Double latitude;
	@CsvBindByPosition(position=3)
	private Double longitude;
	
	public int getP_code() {
		return p_code;
	}
	public void setP_code(int p_code) {
		this.p_code = p_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	@Override
	public String toString() {
		StringBuilder str = new StringBuilder();
		str.append("[p_code:").append(p_code).append(", ");
		str.append("name:").append(name).append(", ");
		str.append("latitude:").append(latitude).append(", ");
		str.append("longitude:").append(longitude).append("]");
		return str.toString();
	}
}
