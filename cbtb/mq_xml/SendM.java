/**
 * Title:        test for ibm MQSeries
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      HT
 * @author meino
 * @version 1.0
 */
 import java.io.*;
import javax.jms.*;
import com.ibm.mq.jms.*;


public class SendM {
  protected String mqManager = "CARGONET.QM1";
  protected String hostname = "187.11.1.127";
  protected String queue = "CBT.IN.Q";
  //protected String queue = "SYSTEM.DEFAULT.LOCAL.QUEUE";

  //default character set is UTF-8
  protected int queueCCSID = 1208;
  //protected int queueCCSID = 1381;
  protected QueueConnection connection = null;
  protected QueueSession session = null;
  protected Queue ioQueue = null;
  protected QueueSender queueSender = null;
  protected String XMLSourceURL =null;

  static  public void main(String[] args) {
   if (args.length != 1) {
      System.err.println("Usage: java SendM XMLSourceURL");
      System.exit(2);
    }
   else{

     SendM sendM =new SendM();
     sendM.setXMLSourceURL( args[0]) ;
     sendM.startSender();
     sendM.endSend();
   }
  }

  public  void startSender() {
	if(mqManager == null || hostname == null || queue == null){
		System.out.println("Error in "+this.getClass().getName()+": haven't define MQ manager, hostname or queue!");
		System.out.println("Fail to start "+this.getClass().getName()+" service");
	}
      try {
        boolean transacted = false;
		// create a	QueueConnectionFactory
    	QueueConnectionFactory factory = new MQQueueConnectionFactory();

        //set attr
        ((MQQueueConnectionFactory)factory).setQueueManager(this.getQueueManager());
      	((MQQueueConnectionFactory)factory).setTransportType(JMSC.MQJMS_TP_CLIENT_MQ_TCPIP);
      	((MQQueueConnectionFactory)factory).setHostName(this.getHostname());
        ((MQQueueConnectionFactory)factory).setCCSID(this.queueCCSID);
		//((MQQueueConnectionFactory)factory).setChannel("MY.CHANNEL");	// add  channel
        //create connection
		connection = factory.createQueueConnection();
      	connection.start();
        System.out.println("------- connection start------");
      	//create session
		session = connection.createQueueSession(transacted, Session.AUTO_ACKNOWLEDGE);
      	//create queue
		ioQueue = session.createQueue(queue);
 //      	((MQQueue)ioQueue).setTargetClient(JMSC.MQJMS_CLIENT_NONJMS_MQ);
//      	((MQQueue)ioQueue).setCCSID(queueCCSID);


		TextMessage outMessage = session.createTextMessage();
		queueSender = session.createSender(ioQueue);
        String s;
		String ts="";
		try{
        DataInputStream in =new DataInputStream(new FileInputStream(this.getXMLSourceURL()));
		BufferedReader d = new BufferedReader(new InputStreamReader(in));

                while((s=d.readLine())!=null)
				//System.out.println();
				ts=ts+s;
                   }catch(FileNotFoundException e){
                   System.out.print("----no find file-----");
                    }catch(IOException e){
                    e.printStackTrace();
                    }
		System.out.println(ts);
		outMessage.setText(ts);
		//create a queueSender

		queueSender.send(outMessage);
		System.out.println("------- success sender------");

		//create a queueReceiver
       	//queueReceiver = session.createReceiver(ioQueue);
	//Set Listener
        //connection.setExceptionListener(this);
    	//queueReceiver.setMessageListener(this);
       	//System.out.println("- "+this.getClass().getName()+" start service OK -");
    } catch (Exception e) {
	  System.out.println("Fail to start "+this.getClass().getName()+" service:"+e);
    }
  }


  public void stopS()  {
    try {
    	if (queueSender != null) {
    	System.out.println("---------- Close "+this.getClass().getName()+" Queue Sender ----------");
       	        queueSender.close();
		queueSender = null;
      	}
      	if (session != null) {
		System.out.println("---------- Close "+this.getClass().getName()+" Queue Session ----------");
		session.close();
		session = null;
      	}
      	if (connection != null) {
		System.out.println("---------- Close "+this.getClass().getName()+" MQ Connection ----------");
		connection.close();
		connection = null;
      	}
    } catch (Exception e) {
	  System.out.println("Fail to stop "+this.getClass().getName()+" service"+ e);
    }
  }

  public void setQueueManager(String mqManager) {
	this.mqManager = mqManager;
  }
  public String getQueueManager() {
	return mqManager;
  }
  public void setHostname(String hostname) {
	this.hostname = hostname;
  }
  public String getHostname() {
	return hostname;
  }
  public void setQueue(String queue) {
	this.queue = queue;
  }
  public String getQueue() {
	return queue;
  }

  //Try to reconnect
  public void onException(JMSException exception) {
    boolean reconnectSuccess = false;
    int retryCounter = 0;
    int sleepTime = 10*1000; //10 seconds
    while(!reconnectSuccess){
   	try{
            Thread.sleep(sleepTime);
            System.out.println(this.getClass().getName()+" try to reconnect :" + retryCounter);
            this.startSender();
            reconnectSuccess = true;
      	}catch(Exception e){
            System.out.print(this.getClass().getName()+" reconnect failed");
      	}
      	retryCounter++;
	if(retryCounter>30 && !reconnectSuccess){ //send email after 5 minutes
		sleepTime = 5*60*1000;  //5 minutes;
		System.out.println(this.getClass().getName()+" : Send email to help desk");
                /////////////////////////
		//TODO: sendMail2HelpDesk();
                /////////////////////////
	}

    }
  }

  public void endSend(){
    try{
      stopS();
    }catch(Exception e){
      e.printStackTrace();
    }
  }
   public void setXMLSourceURL(String theXMLSourceURL){
      this.XMLSourceURL=theXMLSourceURL;
   }

   public String getXMLSourceURL(){
     return this.XMLSourceURL;
   }

}