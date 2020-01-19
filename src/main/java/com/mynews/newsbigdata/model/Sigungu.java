package com.mynews.newsbigdata.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "sigungus")
public class Sigungu {
	@Id
	private int id;
	
	@JoinColumn(name = "province_id")
	private Province province;
	
	@Column()
	private int code;
	
	@Column()
	private String name;
	
	@Column()
	private Double latitude;
	
	@Column()
	private Double longitude;

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Province getProvince() {
		return province;
	}
	
	public void setProvince(Province province) {
		this.province = province;
	}
	
	public int getcode() {
		return code;
	}
	public void setcode(int code) {
		this.code = code;
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
		str.append("[id:").append(id).append(", ");
		str.append("province:").append(province).append(", ");
		str.append("code:").append(code).append(", ");
		str.append("name:").append(name).append(", ");
		str.append("latitude:").append(latitude).append(", ");
		str.append("longitude:").append(longitude).append("]");
		return str.toString();
	}
}
