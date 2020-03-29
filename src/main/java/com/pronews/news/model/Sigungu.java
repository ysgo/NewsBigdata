package com.pronews.news.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "sigungus")
public class Sigungu {
	@Id
	private int id;

	@ManyToOne(fetch = FetchType.LAZY)
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
		str.append("province:").append(province).append(", ");
		str.append("code:").append(code).append(", ");
		str.append("name:").append(name).append(", ");
		str.append("latitude:").append(latitude).append(", ");
		str.append("longitude:").append(longitude).append("]");
		return str.toString();
	}
}
