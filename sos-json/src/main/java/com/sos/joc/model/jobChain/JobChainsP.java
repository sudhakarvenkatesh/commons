
package com.sos.joc.model.jobChain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;


/**
 * job chains with delivery date (permanent part)
 * <p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "deliveryDate",
    "jobChains",
    "nestedJobChains"
})
public class JobChainsP {

    /**
     * delivery date
     * <p>
     * Current date of the JOC server/REST service. Value is UTC timestamp in ISO 8601 YYYY-MM-DDThh:mm:ss.sZ
     * (Required)
     * 
     */
    @JsonProperty("deliveryDate")
    @JsonPropertyDescription("Current date of the JOC server/REST service. Value is UTC timestamp in ISO 8601 YYYY-MM-DDThh:mm:ss.sZ")
    @JacksonXmlProperty(localName = "deliveryDate")
    private Date deliveryDate;
    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("jobChains")
    @JacksonXmlProperty(localName = "jobChain")
    @JacksonXmlElementWrapper(useWrapping = true, localName = "jobChains")
    private List<JobChainP> jobChains = new ArrayList<JobChainP>();
    @JsonProperty("nestedJobChains")
    @JacksonXmlProperty(localName = "nestedJobChain")
    @JacksonXmlElementWrapper(useWrapping = true, localName = "nestedJobChains")
    private List<JobChainP> nestedJobChains = new ArrayList<JobChainP>();

    /**
     * delivery date
     * <p>
     * Current date of the JOC server/REST service. Value is UTC timestamp in ISO 8601 YYYY-MM-DDThh:mm:ss.sZ
     * (Required)
     * 
     */
    @JsonProperty("deliveryDate")
    @JacksonXmlProperty(localName = "deliveryDate")
    public Date getDeliveryDate() {
        return deliveryDate;
    }

    /**
     * delivery date
     * <p>
     * Current date of the JOC server/REST service. Value is UTC timestamp in ISO 8601 YYYY-MM-DDThh:mm:ss.sZ
     * (Required)
     * 
     */
    @JsonProperty("deliveryDate")
    @JacksonXmlProperty(localName = "deliveryDate")
    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("jobChains")
    @JacksonXmlProperty(localName = "jobChain")
    public List<JobChainP> getJobChains() {
        return jobChains;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("jobChains")
    @JacksonXmlProperty(localName = "jobChain")
    public void setJobChains(List<JobChainP> jobChains) {
        this.jobChains = jobChains;
    }

    @JsonProperty("nestedJobChains")
    @JacksonXmlProperty(localName = "nestedJobChain")
    public List<JobChainP> getNestedJobChains() {
        return nestedJobChains;
    }

    @JsonProperty("nestedJobChains")
    @JacksonXmlProperty(localName = "nestedJobChain")
    public void setNestedJobChains(List<JobChainP> nestedJobChains) {
        this.nestedJobChains = nestedJobChains;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this).append("deliveryDate", deliveryDate).append("jobChains", jobChains).append("nestedJobChains", nestedJobChains).toString();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder().append(jobChains).append(deliveryDate).append(nestedJobChains).toHashCode();
    }

    @Override
    public boolean equals(Object other) {
        if (other == this) {
            return true;
        }
        if ((other instanceof JobChainsP) == false) {
            return false;
        }
        JobChainsP rhs = ((JobChainsP) other);
        return new EqualsBuilder().append(jobChains, rhs.jobChains).append(deliveryDate, rhs.deliveryDate).append(nestedJobChains, rhs.nestedJobChains).isEquals();
    }

}
