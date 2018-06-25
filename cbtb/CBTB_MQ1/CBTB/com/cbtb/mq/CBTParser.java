package com.cbtb.mq;

/**
 * Title:        For CBT MQSeries parser XML<br>
 * Description:  This class use orcale xmlparserv2.jar parse XML messages from MQSeries<br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:      HT<br>
 * @author Henry mei
 * @version 1.0
 * @See CBTXMLProcess
 */
import org.xml.sax.*;
import java.io.*;
import java.util.*;
import java.net.*;
import oracle.xml.parser.v2.*;

/**CBTParser parse XML information and deal with them.<br>
 *use oracle xml parser v2.
 */
public class CBTParser  extends HandlerBase{

   Locator locator ;
   boolean isXML=false;
   CBTXMLProcess cbtXMLProcess=new CBTXMLProcess();
   Hashtable CBTAtts=new Hashtable();


   public CBTParser(){
   }
/**parse received XML source String */
   public boolean CBTParser(String XMLSource){
    try {
   	CBTParser sample =new CBTParser();
	Parser  parser =new SAXParser();

	parser.setDocumentHandler(sample);
	parser.setEntityResolver(sample);
	parser.setDTDHandler(sample);
	parser.setErrorHandler(sample);
	try {
          //parse URL file
	 //parser.parse(fileToURL(new File(XMLSource)).toString());

	  //parse String :
	  String s=XMLSource;
	  StringReader reader=new StringReader(s);
	  InputSource source = new InputSource(reader);
	  parser.parse(source);
        }
	catch (SAXParseException e) {
		System.out.println(e.getMessage());
                LogManager.instance.logDebug(e.getMessage());
                return false;
	}
	catch (SAXException e) {
		System.out.println(e.getMessage());
                LogManager.instance.logDebug(e.getMessage());
                return false;
	 }
	}
	catch(Exception e){
	System.out.println(e.toString());
        LogManager.instance.logDebug(e.toString());
        return false;
	}
        return true;
   }

   /**
    * fileToURL method convert file name to URL format
    * @param file filename
    * @return URL
    */
   static URL fileToURL(File file){
     String path =file.getAbsolutePath();
	 String fSep = System.getProperty("file.separator");
	 if ((fSep != null) && (fSep.length() == 1))
	 path =path.replace(fSep.charAt(0),'/');
	 if (path.length()>0&& path.charAt(0)!='/')
	 path ='/'+ path;
	 try {
	 	return new URL("file",null,path);
	 }
	 catch (MalformedURLException e) {
		  throw new Error("unexpected MalformedURLException");
	 }
   }

   public void setDocumentLocator(Locator locator){
	 this.locator =locator;
   }
/** Start document. */
   public void startDocument (){
   }
/** End document. */
   public void endDocument() throws SAXException{
     //cbtXMLProcess.printHashtable();
     //insert into db
     if(isXML){
     //System.out.println("insert begin:");
     if(cbtXMLProcess.addIntoDB())
       {
       //System.out.println("----------receive and change data success----------");
       LogManager.instance.logDebug("----------receive and change data success----------");
       //LogManager.instance.logDebug("###############################################################");
       }else
       {
       //System.out.println("----------change data fail----------");
       LogManager.instance.logDebug("----------change data fail----------");
       }
     }

   }
/** Start element. */
   public void startElement(String name ,AttributeList atts){
     //System.out.println("StartElement :"+name);
     cbtXMLProcess.XMLElementParser(name);
	 for (int i=0;i<atts.getLength() ;i++ ) {
	//  String aname= atts.getName(i);
	//  String type =atts.getType(i);
	  String value = atts.getValue(i);
        //System.out.print("  " +aname+ "(" + type +") ="+value);
	CBTAtts.put(cbtXMLProcess.getTempName(),value);
         }
   }

/** End element. */
   public void endElement (String name) throws SAXException{
     if(this.isIsXML()){
     cbtXMLProcess.setCBTValueList(CBTAtts);
     }
   }

/** Characters. */
  public void characters(char[] cbuf,int start,int len){
    CBTAtts.put(cbtXMLProcess.getTempName(),(new String(cbuf,start,len)));
  }
/**ignorable whitespace*/
   public void ignorableWhitespace ( char[] cbuf,int start,int len){
   }
/** Processing instruction. */
   public void processingInstruction(String target ,String data) throws SAXException{
     System.out.println(" ProcessingInstruction : " +target + " " +data);
   }
   public InputSource resolveEntity(String publicId,String systemId) throws  SAXException {

        if ((systemId !=null) && (systemId.indexOf(CBTXMLConstant.DTD_NAME_ORAGNISATION)!=-1))
        {
          System.out.println("<<<<<<<<<<This XML is organisation XML>>>>>>>>>>");
          this.setIsXML(true);
          cbtXMLProcess.setWhichXML("organisation");
          //System.out.println("---set whichXML success");
        }
        if ((systemId !=null) && (systemId.indexOf(CBTXMLConstant.DTD_NAME_TRUCKER)!=-1))
        {
          System.out.println("<<<<<<<<<<This XML is trucker XML>>>>>>>>>>");
          this.setIsXML(true);
          cbtXMLProcess.setWhichXML("trucker");
        }
        if ((systemId !=null) && (systemId.indexOf(CBTXMLConstant.DTD_NAME_USER_GROUP)!=-1))
        {
          System.out.println("<<<<<<<<<<This XML is user group XML>>>>>>>>>>");
          this.setIsXML(true);
          cbtXMLProcess.setWhichXML("user_group");
        }
        if ((systemId !=null) && (systemId.indexOf(CBTXMLConstant.DTD_NAME_USER_PROFILE)!=-1))
        {
          System.out.println("<<<<<<<<<<This XML is user profile XML>>>>>>>>>>");
          this.setIsXML(true);
          cbtXMLProcess.setWhichXML("user_profile");
        }
        /* Trad Partner is not used
        if ((systemId !=null) && (systemId.indexOf("Trad_Partner.dtd")!=-1))
        {
          System.out.println("--------This XML is Trad Partner XML---------");
          this.setIsXML(true);
          cbtXMLProcess.setWhichXML("Trad_Partner");
        }
        */

	 return null;
   }

   public void notationDecl (String name,String publicId,String systemId){
     System.out.println(" NotationDecl : " +name + " " +publicId+" " +systemId);
   }

   public void unparsedEntityDecl(String name,String publicId,String systemId,String notationName){
     System.out.println(" UnparsedEntityDecl : " +name + " " +publicId+" " +systemId+" " +notationName);
     LogManager.instance.logDebug(" UnparsedEntityDecl : " +name + " " +publicId+" " +systemId+" " +notationName);
   }

   public void warning (SAXParseException e) throws SAXException{
     System.out.println(" Warning  : " +e.getMessage());
     LogManager.instance.logDebug(" Warning  : " +e.getMessage());
   }

   public void error (SAXParseException e) throws SAXException{
     System.out.println(" Error  : " +e.getMessage());
     LogManager.instance.logDebug(" Error  : " +e.getMessage());
   }

   public void fatalError (SAXParseException e) throws SAXException{
     System.out.println(" Fatal Error  : " );
     LogManager.instance.logDebug(" Fatal Error  : " );
     	 throw new SAXException(e.getMessage());
     //LogManager.instance.logDebug("##################################################################");
   }
  /**Set is XML label*/
  public void setIsXML(boolean newIsXML)
  {
    isXML = newIsXML;
  }
  /**Is XML label*/
  public boolean isIsXML()
  {
    return isXML;
  }
}
