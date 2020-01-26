package com.mynews.newsbigdata.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "provinces")
public class Province {
	@Id
	private int id;

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

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
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
		str.append("[id:").append(id).append(", ");
		str.append("code:").append(code).append(", ");
		str.append("name:").append(name).append(", ");
		str.append("latitude:").append(latitude).append(", ");
		str.append("longitude:").append(longitude).append("]");
		return str.toString();
	}
}
