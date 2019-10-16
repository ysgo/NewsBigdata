package vo;

import java.util.Date;

public class MemberVO {
	private String userName;
	private String email;
	private String password;
	private String gender;
	private int generation;
	private Date created_at;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getGeneration() {
		return generation;
	}
	public void setGeneration(int generation) {
		this.generation = generation;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	
	@Override
	public String toString() {
		return"[userName : " + userName + ", email : " + email + ", password : " + password + 
				", gender : " + gender + ", generation : " + generation + ", created_at : " + created_at + "]";
	}
}
