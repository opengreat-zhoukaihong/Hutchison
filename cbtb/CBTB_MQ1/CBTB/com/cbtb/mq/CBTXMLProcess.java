package com.cbtb.mq;
/**
 * Title:        For CBT MQSeries parser  XML<br>
 * Description: according XML DTD deal with data<br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:      HT<br>
 * @author Henry mei
 * @version 1.0
 */
import com.cbtb.ejb.session.*;
import com.cbtb.util.EjbUtil;
import com.cbtb.model.*;
import java.util.*;
import java.sql.*;
import javax.ejb.EJBException;
import java.text.*;
import com.cbtb.util.CbtbConstant;
import com.cbtb.exception.CbtbException;
import java.rmi.RemoteException;

public class CBTXMLProcess {
  /**This String is set for parse organasation*/
  private String parentAddress;
  /**for organasation parse label*/
  private boolean isOrganasationXML=true;
  /**temp name for convert XML to Hashtable */
  private String tempName="none";
  /**which XML label*/
  private String whichXML;
  /**Hashtable to save XML values*/
  private java.util.Hashtable CBTValueList;
  //private SimpleDateFormat df;

  /**To parse XML elements according XML type*/
  public void XMLElementParser(String name){
  if (this.getWhichXML()!=null){
  ///////////////////////////////////////////
  // Parse organisation XML element
  ///////////////////////////////////////////
      if(this.getWhichXML().equalsIgnoreCase("organisation")){
        if (name.equalsIgnoreCase("organisation_address")){
          this.setParentAddress(name);
        }
        if (name.equalsIgnoreCase("billing_address")){
         this.setParentAddress(name);
        }
        if (name.equalsIgnoreCase("address1")){
         name=this.getParentAddress()+"1";
        }
        if (name.equalsIgnoreCase("address2")){
          name=this.getParentAddress()+"2";
        }
        if (name.equalsIgnoreCase("address3")){
           name=this.getParentAddress()+"3";
        }
        if (name.equalsIgnoreCase("address4")){
         name=this.getParentAddress()+"4";
        }

        this.setTempName(name);
     }//if organisation end
  ///////////////////////////////////////////////////
  //parse other XML element
  ///////////////////////////////////////////////////
      else{
      this.setTempName(name);
      }
  }//XML element parse over
}


/**Get which XML label*/
  public String getWhichXML()
  {
    return whichXML;
  }
/**Set which XML label*/
  public void setWhichXML(String newWhichXML)
  {
    whichXML = newWhichXML;
  }
   /**Set organisation address's parent label*/
   public void setParentAddress(String theParentAddress){
      this.parentAddress=theParentAddress;
   }
   /**Get organisation address's parent label*/
  public String getParentAddress(){
     return this.parentAddress;
   }
  /**set tempName method*/
   public void setTempName(String theTempName){
      this.tempName=theTempName;
   }

  /**get tempName method*/
  public String getTempName(){
     return this.tempName;
   }
  /**Set parsed XML values to Hashtable*/
  public void setCBTValueList(java.util.Hashtable newCBTValueList)
  {
    CBTValueList = newCBTValueList;
  }
  /**Get Hashtable have been converted*/
  public java.util.Hashtable getCBTValueList()
  {
    return CBTValueList;
  }

   /**print parsed XML to Hashtable key and value*/
   public void printHashtable(){
      Enumeration enumeration = CBTValueList.keys();
      while (enumeration.hasMoreElements())
      {
         Object key = enumeration.nextElement();
         System.out.println(key.toString()+"="+CBTValueList.get(key));
       }
   }
/**addIntoDB is a method to insert or update receive and parsed XML information
 *into DB,In the part ,used some our EJB methods.
 **/
   public boolean addIntoDB(){
   boolean isAdd=false;
  ////////////////////////////////////////////////////////
  // add organisation XML information into DB
  ///////////////////////////////////////////////////////
  if(this.getWhichXML()!=null){
    EjbUtil ejbUtil = new EjbUtil();
    boolean isNew=true;

    if(this.getWhichXML().equalsIgnoreCase("organisation") && CBTValueList.get("organisation_id")!=null){
    CompanyManager companyManager=ejbUtil.getCompanyManager();
    CompanyProfileModel cpm =new CompanyProfileModel();
    cpm=null;

    try{
    cpm = companyManager.findCompanyProfile((String)CBTValueList.get("organisation_id"));
      if (cpm.getCompanyName()!=null && cpm.getCompanyName().length()>0){
      isNew = false;
      //System.out.println(":::::have data in db:::::");
      LogManager.instance.logDebug(":::::Have record in DB,I will do update opreation");
      //System.out.println(cpm.getCompanyName());
      }
    }catch(EJBException ex){
      isNew =true;
      //System.out.println(":::::EJBException: no data in db:::::");
      LogManager.instance.logDebug(":::::Have no record in DB,I will do insert opreation");
      cpm =new CompanyProfileModel();
    }catch(Exception e){
      isNew =true;
      //System.out.println(":::::Exception: no data in db :::::");
      LogManager.instance.logDebug(":::::Have no record in DB,I will do insert opreation---");
      cpm =new CompanyProfileModel();
    }
    DocRecStatusModel drsm=new DocRecStatusModel();
    drsm.setCompanyId((String)CBTValueList.get("organisation_id"));
    drsm.setDocumentId((String)CBTValueList.get("document_id"));
    //drsm.setReceivingStauts((String)CBTValueList.get("document_status"));
    drsm.setReceivingStauts(CbtbConstant.DOCUMENT_RECEIVING_STATUS_VALID);

    cpm.setPrefLanguage((String)CBTValueList.get("perfer_language"));
    cpm.setCompanyId((String)CBTValueList.get("organisation_id"));
    cpm.setCompanyName((String)CBTValueList.get("organisation_name"));
    cpm.setCompanyChineseName((String)CBTValueList.get("organisation_name"));
    cpm.setCompanyAddr1((String)CBTValueList.get("organisation_address1"));
    cpm.setCompanyAddr2((String)CBTValueList.get("organisation_address2"));
    cpm.setCompanyAddr3((String)CBTValueList.get("organisation_address3"));
    cpm.setCompanyAddr4((String)CBTValueList.get("organisation_address4"));
    cpm.setTelephoneNo((String)CBTValueList.get("telephone"));
    cpm.setBillingStatementContactphone((String)CBTValueList.get("telephone"));
    cpm.setPrefCommChannel((String)CBTValueList.get("perfer_channel"));
    cpm.setBillingOrStatementAddr1((String)CBTValueList.get("billing_address1"));
    cpm.setBillingOrStatementAddr2((String)CBTValueList.get("billing_address2"));
    cpm.setBillingOrStatementAddr3((String)CBTValueList.get("billing_address3"));
    cpm.setBillingOrStatementAddr4((String)CBTValueList.get("billing_address4"));
    cpm.setMobileNo((String)CBTValueList.get("mobile_no"));
    cpm.setWebSite((String)CBTValueList.get("web_site"));
    cpm.setContactPerson((String)CBTValueList.get("contact_person"));
    cpm.setContactChinesePerson((String)CBTValueList.get("contact_person"));
    cpm.setSentChinesePerson((String)CBTValueList.get("contact_person"));
    cpm.setSentPerson((String)CBTValueList.get("contact_person"));
    cpm.setEmailAddr((String)CBTValueList.get("email"));
    cpm.setBillingStatementContactemail((String)CBTValueList.get("email"));
    cpm.setBusiRegistrationNum((String)CBTValueList.get("business_registration_no"));
    cpm.setFaxNo((String)CBTValueList.get("fax_no"));
    cpm.setBillingStatementContactfax((String)CBTValueList.get("fax_no"));
    cpm.setRegistrationRefNum((String)CBTValueList.get("registration_reference_no"));
    //payment term
    String paymentTerm=null;
    if ((CBTValueList.get("payment_terms")!=null) && (CBTValueList.get("payment_terms").toString().equalsIgnoreCase(CBTXMLConstant.ORGANISATION_PAYMENT_TERMS_CREDIT)))
    paymentTerm=CbtbConstant.COMPANY_PAYMENT_TERMS_CREDIT;
    if ((CBTValueList.get("payment_terms")!=null) && (CBTValueList.get("payment_terms").toString().equalsIgnoreCase(CBTXMLConstant.ORGANISATION_PAYMENT_TERMS_CASH)))
    paymentTerm=CbtbConstant.COMPANY_PAYMENT_TERMS_CASH;
    cpm.setPaymentTerms(paymentTerm);
    //registration channel
    String registrationChannel =null;
    if ((CBTValueList.get("registration_channel")!=null) && (CBTValueList.get("registration_channel").toString().equalsIgnoreCase(CBTXMLConstant.REGISTRATION_CHANNEL_EMAIL)))
    registrationChannel=CbtbConstant.CAPTURE_CHANNEL_EMAIL;
    if ((CBTValueList.get("registration_channel")!=null) && (CBTValueList.get("registration_channel").toString().equalsIgnoreCase(CBTXMLConstant.REGISTRATION_CHANNEL_FAX )))
    registrationChannel=CbtbConstant.CAPTURE_CHANNEL_FAX ;
    if ((CBTValueList.get("registration_channel")!=null) && (CBTValueList.get("registration_channel").toString().equalsIgnoreCase(CBTXMLConstant.REGISTRATION_CHANNEL_INTERNET)))
    registrationChannel=CbtbConstant.CAPTURE_CHANNEL_INTERNET;
    if ((CBTValueList.get("registration_channel")!=null) && (CBTValueList.get("registration_channel").toString().equalsIgnoreCase(CBTXMLConstant.REGISTRATION_CHANNEL_PHONE)))
    registrationChannel=CbtbConstant.CAPTURE_CHANNEL_PHONE;
    cpm.setRegistrationChannel(registrationChannel);
      //company type
      if ((CBTValueList.get("organisation_type")!=null) && (CBTValueList.get("organisation_type").toString().equalsIgnoreCase(CBTXMLConstant.ORGANISATION_TYPE_SHIPPER)))
      {String companyType = CbtbConstant.COMPANY_TYPE_SHIPPER;
      cpm.setCompanyType(companyType);
      drsm.setSubmitParty(companyType);
      }else{
      String companyType = CbtbConstant.COMPANY_TYPE_TRUCKER;
      cpm.setCompanyType(companyType);
      drsm.setSubmitParty(companyType);
      }

    //company status
      if ((CBTValueList.get("status")!=null) && (CBTValueList.get("status").toString().equalsIgnoreCase(CBTXMLConstant.ORGANISATION_STATUS_ACTIVATE)))
      cpm.setCompanyStatus(CbtbConstant.COMPANY_ACTIVE);
      if ((CBTValueList.get("status")!=null) && (CBTValueList.get("status").toString().equalsIgnoreCase(CBTXMLConstant.ORGANISATION_STATUS_PENDING)))
      cpm.setCompanyStatus(CbtbConstant.COMPANY_SUSPEND) ;
      //if ((CBTValueList.get("status")!=null) && (CBTValueList.get("status").toString().equalsIgnoreCase("APPROVED")))
      //if ((CBTValueList.get("status")!=null) && (CBTValueList.get("status").toString().equalsIgnoreCase("REJECTED")))


   //registration date
   try{
   String registrationDate =(String)CBTValueList.get("registration_date")+" 00:00:00.0";
   cpm.setRegistrationDate(registrationDate);
   }catch(Exception e){
   //System.out.println(":::::Registration Date format error:::::");
   LogManager.instance.logDebug(":::::Registration Date format error: "+(String)CBTValueList.get("registration_date"));
   }


    try{
      if (isNew){
       if(companyManager.addCompanyProfile(cpm)) { //add company profile into db
       //System.out.println(":::::orgXML company info parse and add into DB success:::::");
       LogManager.instance.logDebug(":::::orgXML company info parse and add into DB success:::::");
       isAdd = true;
       }

      }else{
       if(companyManager.updateCompanyProfile(cpm)){
       //System.out.println(":::::orgXML company info parse and update DB success:::::");
       LogManager.instance.logDebug(":::::orgXML company info parse and update DB success:::::");
       isAdd = true;
       }
      }
      //update document info
      if(drsm.getDocumentId()==null){
        LogManager.instance.logDebug(":::::This Org XML no document info");
      }
      if(drsm.getDocumentId()!=null && !companyManager.updateDocReceivingStatus(drsm)){
        //System.out.println("No update document,because no document data receive");
        LogManager.instance.logDebug(":::::Document info process fail,Pls check content:::::");
      }
      //else{
      //System.out.println(drsm.getCompanyId());
      //System.out.println(drsm.getSubmitParty());
      //System.out.println(drsm.getReceivingStauts());
      //System.out.println(drsm.getDocumentId());
      //System.out.println("Update document");
      //LogManager.instance.logDebug(":::::Document data process success:::::");
      //}
    }catch(Exception e){
     //System.out.println(":::::"+e.getMessage());
     LogManager.instance.logDebug(":::::Org data process error: "+e.getMessage());
     return isAdd;
    }
   }//if organization add into db end
  ////////////////////////////////////////////////////////
  // add user  XML information into DB
  ///////////////////////////////////////////////////////
    if(this.getWhichXML().equalsIgnoreCase("user_profile")){
      com.cbtb.ejb.session.SecurityManager securityManager = ejbUtil.getSecurityManager();

       if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_CREATE)){
        try{
        securityManager.createUser((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("user_id"),(String)CBTValueList.get("password"),(String)CBTValueList.get("description"));
        isAdd =true;
        LogManager.instance.logDebug(":::::Create user("+(String)CBTValueList.get("user_id")+") success ");
        }catch(CbtbException e){
        //System.out.println("Create user("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Create user("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        }catch(RemoteException re){
        }
      }
      if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_CHANGE)){
        try{
        securityManager.updateUser((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("user_id"),"N",(String)CBTValueList.get("password"),(String)CBTValueList.get("description"));
        isAdd =true;
        LogManager.instance.logDebug(":::::Change user("+(String)CBTValueList.get("user_id")+") success ");
        }catch(CbtbException e){
        //System.out.println("Change user("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Change user("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        }catch(RemoteException re){
        }
      }
      if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_DELETE)){
        try{
        securityManager.deleteUser((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("user_id"));
        isAdd =true;
        LogManager.instance.logDebug(":::::Delete user("+(String)CBTValueList.get("user_id")+") success ");
        }catch(CbtbException e){
        //System.out.println("Delete user("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Delete user("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        }catch(RemoteException re){
        }
      }
      if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_SUSPEND)){
        try{
        securityManager.updateUser((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("user_id"),"Y",(String)CBTValueList.get("password"),(String)CBTValueList.get("description"));
        isAdd =true;
        LogManager.instance.logDebug(":::::Change user("+(String)CBTValueList.get("user_id")+") success ");
        }catch(CbtbException e){
        //System.out.println("Change user("+(String)CBTValueList.get("user_id")+") status fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Change user("+(String)CBTValueList.get("user_id")+") status fail: "+e.getMessage());
        }catch(RemoteException re){
        }
      }
      if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_ACTIVE)){
        try{
        securityManager.updateUser((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("user_id"),"N",(String)CBTValueList.get("password"),(String)CBTValueList.get("description"));
        isAdd =true;
        LogManager.instance.logDebug(":::::Change user("+(String)CBTValueList.get("user_id")+") success ");
        }catch(CbtbException e){
        //System.out.println("Change user("+(String)CBTValueList.get("user_id")+") status fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Change user("+(String)CBTValueList.get("user_id")+") status fail: "+e.getMessage());
        }catch(RemoteException re){
        }
      }
    }
  ////////////////////////////////////////////////////////
  // add user group XML information into DB
  ///////////////////////////////////////////////////////
    if(this.getWhichXML().equalsIgnoreCase("user_group")){
      com.cbtb.ejb.session.SecurityManager securityManager = ejbUtil.getSecurityManager();
        //----
        String userType=null;
        if(CBTValueList.get("group_id")!=null && CBTValueList.get("group_id").toString().equalsIgnoreCase(CBTXMLConstant.USER_GROUP_ID_ADMIN))
        userType=CbtbConstant.EXTERNAL_USER_ADMIN ;
        else
        userType=CbtbConstant.EXTERNAL_USER_OPERATOR;

       if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_CREATE)){

       try{
        securityManager.addExternalGroupMembership((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("user_id"),userType);
        isAdd =true;
        LogManager.instance.logDebug(":::::Create user("+(String)CBTValueList.get("user_id")+") group("+(String)CBTValueList.get("user_id")+") success");
        }catch(CbtbException e){
        //System.out.println("Create user("+(String)CBTValueList.get("user_id")+") group("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Create user("+(String)CBTValueList.get("user_id")+") group("+(String)CBTValueList.get("user_id")+") fail: "+e.getMessage());
        }catch(RemoteException re){
        LogManager.instance.logDebug(":::::Remote method error.Pls check");
        }
      }
       if((String)CBTValueList.get("action")!=null && CBTValueList.get("action").toString().equalsIgnoreCase(CBTXMLConstant.ACTION_DELETE)){
        try{
        securityManager.removeExternalGroupMembership((String)CBTValueList.get("domain_id"),(String)CBTValueList.get("domain_id"),userType);
        //System.out.println("I have delete user ");
        isAdd =true;
        LogManager.instance.logDebug(":::::Delete user("+(String)CBTValueList.get("user_id")+") group("+(String)CBTValueList.get("domain_id")+") success ");
        }catch(CbtbException e){
        //System.out.println("Delete user("+(String)CBTValueList.get("user_id")+") group("+(String)CBTValueList.get("domain_id")+") fail: "+e.getMessage());
        LogManager.instance.logDebug(":::::Delete user("+(String)CBTValueList.get("user_id")+") group("+(String)CBTValueList.get("domain_id")+") fail: "+e.getMessage());
        }catch(RemoteException re){
        }
      }
    }

  ////////////////////////////////////////////////////////
  // add trucker XML information into DB
  ///////////////////////////////////////////////////////
    if(this.getWhichXML().equalsIgnoreCase("trucker")){
    CompanyManager companyManager=ejbUtil.getCompanyManager();
    TruckerDataModel tdm =new TruckerDataModel();
    tdm=null;

    try{
    tdm = companyManager.findTruckerData((String)CBTValueList.get("Trucker_ID"));
      if (tdm!=null)
      {isNew = false;
      //System.out.println(":::::have data in db:::::");
      LogManager.instance.logDebug(":::::Have record in DB,I will do update opreation:::::");
      }
    }catch(EJBException ex){
      isNew =true;
      //System.out.println(":::::Have no record in DB,I will do insert opreation:::::");
      LogManager.instance.logDebug(":::::Have no record in DB,I will do insert opreation:::::");
      tdm =new TruckerDataModel();
    }catch(Exception e){
       isNew =true;
      //System.out.println(":::::Have no record in DB,I will do insert opreation:::::");
      LogManager.instance.logDebug(":::::Have no record in DB,I will do insert opreation:::::");
      tdm =new TruckerDataModel();
    }

    tdm.setCarryWeight((String)CBTValueList.get("Carry_Weight"));
    tdm.setTruckerId((String)CBTValueList.get("Trucker_ID"));
    //System.out.println(tdm.getTruckerId());
    tdm.setTruckerName((String)CBTValueList.get("Trucker_Name"));
    tdm.setTruckerChineseName((String)CBTValueList.get("Trucker_Name"));
    tdm.setTruckModelNo((String)CBTValueList.get("Truck_Model_No"));
    tdm.setCompanyId((String)CBTValueList.get("Organization_ID"));
    tdm.setInlandLicenseNo((String)CBTValueList.get("Inland_License_No"));
    tdm.setInlandPlateNo((String)CBTValueList.get("Inland_Plate_No"));
    tdm.setHkPlateNo((String)CBTValueList.get("HK_Plate_No"));
    tdm.setHkPagerNo((String)CBTValueList.get("HK_Pager_No"));
    tdm.setHkId((String)CBTValueList.get("HK_ID"));
    //tdm.setReasonId((String)CBTValueList.get("Reason_ID"));
    tdm.setTruckerAddr4((String)CBTValueList.get("address4"));
    tdm.setTruckerAddr3((String)CBTValueList.get("address3"));
    tdm.setTruckerAddr2((String)CBTValueList.get("address2"));
    tdm.setTruckerAddr1((String)CBTValueList.get("address1"));
    tdm.setTruckColor((String)CBTValueList.get("Truck_Color"));
    tdm.setInlandPagerNo((String)CBTValueList.get("Inland_Pager_No"));
    tdm.setInlandTelephoneNo((String)CBTValueList.get("Inland_Telephone_No"));
    tdm.setHkLicenseNo((String)CBTValueList.get("HK_License_No"));
    tdm.setInlandMobileNo((String)CBTValueList.get("Inland_Mobile_No"));
    tdm.setHkTelephoneNo((String)CBTValueList.get("HK_Telephone_No"));
    tdm.setHkMobileNo((String)CBTValueList.get("HK_Mobile_No"));
    String truckerStatus = CbtbConstant.TRUCKER_REGISTRATION_IN_PROGRESS;
    tdm.setTruckStatus(truckerStatus);

    try{
    //System.out.println("is new :"+isNew);
      if (isNew){
      java.util.Date cDate =new java.util.Date();
      Timestamp cDateTime =new Timestamp((long)cDate.getTime());
      tdm.setCreationDate(cDateTime);
       if(companyManager.addTruckerData(tdm)) { //add trucker into db
       //System.out.println(":::::orgXML trucker("+tdm.getTruckerId()+") info parse and add into DB success:::::");
       LogManager.instance.logDebug(":::::orgXML trucker("+tdm.getTruckerId()+") info parse and add into DB success:::::");
       isAdd = true;
       }
      }else{
       if(companyManager.updateTruckerData(tdm)){
       //System.out.println(":::::orgXML trucker("+tdm.getTruckerId()+") info parse and update DB success:::::");
       LogManager.instance.logDebug(":::::orgXML trucker("+tdm.getTruckerId()+") info parse and update DB success:::::");
       isAdd = true;
       }
      }
    }catch(Exception e){
     //System.out.println(":::::Error:"+e.getMessage());
     LogManager.instance.logDebug(":::::Trucker info Error:"+e.getMessage());
     return isAdd;
    }
    }//add trucker end
   }//if id  xml end
    return isAdd;
  }
}