package vo;

import com.opencsv.bean.CsvBindByPosition;

public class SigunguVO {
	@CsvBindByPosition(position = 0)
	private int p_code;
	@CsvBindByPosition(position = 1)
	private int s_code;
	@CsvBindByPosition(position = 2)
	private String s_name;
	@CsvBindByPosition(position = 3)
	private Double s_latitude;
	@CsvBindByPosition(position = 4)
	private Double s_longitude;

	public int getP_code() {
		return p_code;
	}
	public void setP_code(int p_code) {
		this.p_code = p_code;
	}
	public int getS_code() {
		return s_code;
	}
	public void setS_code(int s_code) {
		this.s_code = s_code;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public Double getS_latitude() {
		return s_latitude;
	}
	public void setS_latitude(Double s_latitude) {
		this.s_latitude = s_latitude;
	}
	public Double getS_longitude() {
		return s_longitude;
	}
	public void setS_longitude(Double s_longitude) {
		this.s_longitude = s_longitude;
	}

	@Override
	public String toString() {
		StringBuilder str = new StringBuilder();
		str.append("[p_code:").append(p_code).append(", ");
		str.append("s_sode:").append(s_code).append(", ");
		str.append("s_name:").append(s_name).append(", ");
		str.append("s_latitude:").append(s_latitude).append(", ");
		str.append("s_longitude:").append(s_longitude).append("]");
		return str.toString();
	}
}
