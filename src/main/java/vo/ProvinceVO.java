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
	public String getP_name() {
		return name;
	}
	public void setP_name(String name) {
		this.name = name;
	}
	public Double getP_latitude() {
		return latitude;
	}
	public void setP_latitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getP_longitude() {
		return longitude;
	}
	public void setP_longitude(Double longitude) {
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
