package main.java.CustomerSearch.Dto;

import java.sql.Date;

public class Mst_Customer_Type_ConversionDto {


	    private int conversionId;
	    private String sourceType;
	    private int targetType;
	    private String description;
	    private int deleteFlag;
	    private String createdBy;
		private Date createdAt;
		private String updatedBy;
		private Date updatedAt;

	    public int getConversionId() {
	        return conversionId;
	    }

	    public void setConversionId(int conversionId) {
	        this.conversionId = conversionId;
	    }

	    public String getSourceType() {
	        return sourceType;
	    }

	    public void setSourceType(String sourceType) {
	        this.sourceType = sourceType;
	    }

	    public int getTargetType() {
	        return targetType;
	    }

	    public void setTargetType(int targetType) {
	        this.targetType = targetType;
	    }

	    public String getDescription() {
	        return description;
	    }

	    public void setDescription(String description) {
	        this.description = description;
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
	}
