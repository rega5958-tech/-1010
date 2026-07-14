package main.java.CustomerSearch.Dto;

import java.sql.Date;

public class Tgt_CustomerSearchDto {

	

	private int customerId;
	private String customerName;
	private String address;
	private int customerTypeId;
	private int deleteFlag;
	private String createdBy;
	private Date createdAt;
	private String updatedBy;
	private Date updatedAt;

	// getter / setter
	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getCustomerTypeId() {
		return customerTypeId;
	}

	public void setCustomerTypeId(int customerTypeId) {
		this.customerTypeId = customerTypeId;
	}

	public int getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(int deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	@Override
	public String toString() {
		return "Tgt_CustomerSearchDto [customerId=" + customerId + ", customerName=" + customerName + ", address="
				+ address + ", customerTypeId=" + customerTypeId + ", deleteFlag=" + deleteFlag + ", createdBy="
				+ createdBy + ", createdAt=" + createdAt + ", updatedBy=" + updatedBy + ", updatedAt=" + updatedAt
				+ "]";
	}
}
