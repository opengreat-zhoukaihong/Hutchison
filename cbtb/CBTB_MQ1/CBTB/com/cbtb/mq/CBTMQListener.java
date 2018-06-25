package com.cbtb.mq;

/**
 * Title:       write for listener ibm MQSeries message.<br>
 * Description: <br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:      HT<br>
 * @author Henry mei
 * @version 1.0
 */
import javax.jms.*;
import com.ibm.mq.jms.*;
//import net.line.fortress.apps.system.message.mq.*;
import com.cbtb.web.WebOperator;

/**
 * CBT MQSeries Listener,When messages reach MQseries Server,
 * Listener auto deal with messages's information with XML format.
 */
public class CBTMQListener implements MessageListener, ExceptionListener{

//  protected String mqManager = "CARGONET.QM1";
//  protected String hostname = "187.11.1.127";
//  protected String queue = "CBT.IN.Q";
  protected String mqManager = null;
  protected String hostname = null;
  protected String queue = null;

  //default character set is UTF-8
  protected int queueCCSID = 1208;
  //protected int queueCCSID = 1381;
  protected QueueConnection connection = null;
  protected QueueSession session = null;
  protected Queue ioQueue = null;
  protected QueueReceiver queueReceiver = null;

  public CBTMQListener() {
    ConfigManager cfgMgr = ConfigManager.getInstance();
    mqManager = cfgMgr.getProperty("com.cbtb.mq.queuemgr");
    hostname = cfgMgr.getProperty("com.cbtb.mq.queuehost");
    queue = cfgMgr.getProperty("com.cbtb.mq.listenqueue");
    String strCCSID = cfgMgr.getProperty("com.cbtb.mq.ccsid");
    if(strCCSID != null){
      queueCCSID = Integer.parseInt(strCCSID);
    }
    LogManager.instance.logInfo("----------------------------------------------------------------------------");
    LogManager.instance.logInfo("MQListener: Hostname = " + hostname);
    LogManager.instance.logInfo("MQListener: Queue Manager = " + mqManager);
    LogManager.instance.logInfo("MQListener: Listening queue = " + queue);
    LogManager.instance.logInfo("MQListener: CCSID = " + queueCCSID);
    try{
      startService();
    }catch(Exception e){
      e.printStackTrace();
    }
  }


  public void onMessage(Message message) {
	LogManager.instance.logDebug("#######################################################################");
	String receivedMessage = null;
	try {
	   	if (message instanceof TextMessage) {
			LogManager.instance.logDebug("---------- Text Message ----------");
                        System.out.println("---------- Text Message ----------");
        	        receivedMessage = ((TextMessage) message).getText();
	   	} else if (message instanceof BytesMessage) {
			LogManager.instance.logDebug("---------- Bytes Message ----------");
	   	} else if (message instanceof MapMessage) {
    	   	        LogManager.instance.logDebug("---------- Map Message ----------");
	   	} else if (message instanceof ObjectMessage) {
			LogManager.instance.logDebug("---------- Object Message ----------");
                }

                /////////////////////////////
                //TODO:Process the message
                /////////////////////////////
                dealMessage(receivedMessage);


	} catch (Exception e) {
		e.printStackTrace();
	}
  }


  //public void startService() throws MQConnectionException {
  public void startService(){
	if(mqManager == null || hostname == null || queue == null){
		LogManager.instance.logDebug("Error in "+this.getClass().getName()+": haven't define MQ manager, hostname or queue!");
		//throw new MQConnectionException("Fail to start "+this.getClass().getName()+" service");
                System.out.println("Fail to start "+this.getClass().getName()+" service");
	}
    try {
        boolean transacted = false;
    	QueueConnectionFactory factory = new MQQueueConnectionFactory();

        ((MQQueueConnectionFactory)factory).setQueueManager(this.getQueueManager());
      	((MQQueueConnectionFactory)factory).setTransportType(JMSC.MQJMS_TP_CLIENT_MQ_TCPIP);
      	((MQQueueConnectionFactory)factory).setHostName(this.getHostname());
        ((MQQueueConnectionFactory)factory).setCCSID(this.queueCCSID);
       connection = factory.createQueueConnection();

      	connection.start();
      	session = connection.createQueueSession(transacted, Session.AUTO_ACKNOWLEDGE);
      	ioQueue = session.createQueue(queue);
      	((MQQueue)ioQueue).setTargetClient(JMSC.MQJMS_CLIENT_NONJMS_MQ);
      	((MQQueue)ioQueue).setCCSID(queueCCSID);
       	queueReceiver = session.createReceiver(ioQueue);

	//Set Listener
        connection.setExceptionListener(this);
	queueReceiver.setMessageListener(this);
       	System.out.println("- "+this.getClass().getName()+" start service OK -");
        LogManager.instance.logInfo("- "+this.getClass().getName()+" start service OK -");
    }catch(JMSException ex){
    this.onException(ex);
    }
    catch (Exception e) {
        LogManager.instance.logInfo("Fail to start "+this.getClass().getName()+" service", e);
	//throw new MQConnectionException("Fail to start "+this.getClass().getName()+" service", e);
        System.out.println("Fail to start "+this.getClass().getName()+" service");
    }
  }


  //public void stopService() throws MQConnectionException {
  public void stopService() {
    try {
    	if (queueReceiver != null) {
		LogManager.instance.logDebug("---------- Close "+this.getClass().getName()+" Queue Receiver ----------");
       	        queueReceiver.close();
		queueReceiver = null;
      	}
      	if (session != null) {
		LogManager.instance.logDebug("---------- Close "+this.getClass().getName()+" Queue Session ----------");
		session.close();
		session = null;
      	}
      	if (connection != null) {
		LogManager.instance.logDebug("---------- Close "+this.getClass().getName()+" MQ Connection ----------");
		connection.close();
		connection = null;
      	}
    } catch (Exception e) {
	LogManager.instance.logInfo("Fail to stop "+this.getClass().getName()+" service", e);
        System.out.println("Fail to stop "+this.getClass().getName()+" service");
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

/**On Exception , Try to reconnect.over 30 times,send mail to help*/
  public void onException(JMSException exception) {
    boolean reconnectSuccess = false;
    int retryCounter = 0;
    int sleepTime = 10*1000; //10 seconds
    while(!reconnectSuccess){
   	try{
            Thread.sleep(sleepTime);
            LogManager.instance.logDebug(this.getClass().getName()+" try to reconnect :" + retryCounter);
            retryCounter++;
            this.startService();
            reconnectSuccess = true;
      	}catch(Exception e){
            System.out.print(this.getClass().getName()+" reconnect failed");
      	}

	if(retryCounter>30 && !reconnectSuccess){ //send email after 5 minutes
		sleepTime = 5*60*1000;  //5 minutes;
		LogManager.instance.logDebug(this.getClass().getName()+" : Send email to help desk");
                /////////////////////////
		//TODO: sendMail2HelpDesk();
                /////////////////////////
	}

    }
  }

       /**deal with message*/
        public void dealMessage(String receivedMessage){
        LogManager.instance.logDebug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	LogManager.instance.logDebug("Received Message from MQ Listener: \n"+receivedMessage);
	LogManager.instance.logDebug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        try{
                //split header and XML body from message
                int i  =receivedMessage.indexOf("<?xml");
                String XMLSource =receivedMessage.substring(i);
                CBTParser parser=new CBTParser();
                if(XMLSource!=null&&XMLSource.trim().length()>0)

                parser.CBTParser(XMLSource);
                }catch (Exception e){
                System.out.println("Error:"+e.getMessage());
                LogManager.instance.logInfo("Error:"+e.getMessage());
                }
        }

  public void finalize(){
    try{
      stopService();
    }catch(Exception e){
      e.printStackTrace();
    }
  }
}