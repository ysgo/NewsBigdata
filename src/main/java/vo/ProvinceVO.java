package vo;

import com.opencsv.bean.CsvBindByPosition;

public class ProvinceVO {
	@CsvBindByPosition(position=0)
	private int p_code;
	@CsvBindByPosition(position=1)
	private String p_name;
	@CsvBindByPosition(position=2)
	private Double p_latitude;
	@CsvBindByPosition(position=3)
	private Double p_longitude;
	
	public int getP_code() {
		return p_code;
	}
	public void setP_code(int p_code) {
		this.p_code = p_code;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public Double getP_latitude() {
		return p_latitude;
	}
	public void setP_latitude(Double p_latitude) {
		this.p_latitude = p_latitude;
	}
	public Double getP_longitude() {
		return p_longitude;
	}
	public void setP_longitude(Double p_longitude) {
		this.p_longitude = p_longitude;
	}
	
	@Override
	public String toString() {
		StringBuilder str = new StringBuilder();
		str.append("[p_code:").append(p_code).append(", ");
		str.append("p_name:").append(p_name).append(", ");
		str.append("p_latitude:").append(p_latitude).append(", ");
		str.append("p_longitude:").append(p_longitude).append("]");
		return str.toString();
	}
}
