package vo;

import com.opencsv.bean.CsvBindByPosition;

public class SigunguVO {
	@CsvBindByPosition(position = 0)
	private int p_code;
	@CsvBindByPosition(position = 1)
	private int s_code;
	@CsvBindByPosition(position = 2)
	private String name;
	@CsvBindByPosition(position = 3)
	private Double latitude;
	@CsvBindByPosition(position = 4)
	private Double longitude;

	public int getP_code() {
		return p_code;
	}
	public void setP_code(int p_code) {
		this.p_code = p_code;
	}
	public int getcode() {
		return s_code;
	}
	public void setcode(int s_code) {
		this.s_code = s_code;
	}
	public String getname() {
		return name;
	}
	public void setname(String name) {
		this.name = name;
	}
	public Double getlatitude() {
		return latitude;
	}
	public void setlatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getlongitude() {
		return longitude;
	}
	public void setlongitude(Double longitude) {
		this.longitude = longitude;
	}

	@Override
	public String toString() {
		StringBuilder str = new StringBuilder();
		str.append("[p_code:").append(p_code).append(", ");
		str.append("s_code:").append(s_code).append(", ");
		str.append("name:").append(name).append(", ");
		str.append("latitude:").append(latitude).append(", ");
		str.append("longitude:").append(longitude).append("]");
		return str.toString();
	}
}
