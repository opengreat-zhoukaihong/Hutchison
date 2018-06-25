package net.line.fortress.apps.system.message.mq;

import net.line.fortress.apps.system.*;
import javax.jms.*;
import com.ibm.mq.jms.*;


public class MQListener implements MessageListener, ExceptionListener{

  protected String mqManager = null;
  protected String hostname = null;
  protected String queue = null;
  //default character set is UTF-8
  protected int queueCCSID = 1208;
  protected QueueConnection connection = null;
  protected QueueSession session = null;
  protected Queue ioQueue = null;
  protected QueueReceiver queueReceiver = null;

  public MQListener() {
    ConfigManager cfgMgr = ConfigManager.getInstance();
    mqManager = cfgMgr.getProperty("net.line.system.message.mq.queuemgr");
    hostname = cfgMgr.getProperty("net.line.system.message.mq.queuehost");
    queue = cfgMgr.getProperty("net.line.system.message.mq.listenqueue");
    String strCCSID = cfgMgr.getProperty("net.line.system.message.mq.ccsid");
    if(strCCSID != null){
      queueCCSID = Integer.parseInt(strCCSID);
    }
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
	LogManager.instance.logDebug("---------- MQ Listener onMessage ----------");
	String receivedMessage = null;
	try {
	   	if (message instanceof TextMessage) {
			LogManager.instance.logDebug("---------- Text Message ----------");
        	        receivedMessage = ((TextMessage) message).getText();
	   	} else if (message instanceof BytesMessage) {
			LogManager.instance.logDebug("---------- Bytes Message ----------");
	   	} else if (message instanceof MapMessage) {
    	   	        LogManager.instance.logDebug("---------- Map Message ----------");
	   	} else if (message instanceof ObjectMessage) {
			LogManager.instance.logDebug("---------- Object Message ----------");
                }
		LogManager.instance.logDebug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		LogManager.instance.logDebug("Received Message from MQ Listener: <" + receivedMessage + ">");
		LogManager.instance.logDebug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                /////////////////////////////
                //TODO:Process the message
                /////////////////////////////
	} catch (Exception e) {
		e.printStackTrace();
	}
  }

  public void startService() throws MQConnectionException {
	if(mqManager == null || hostname == null || queue == null){
		LogManager.instance.logDebug("Error in "+this.getClass().getName()+": haven't define MQ manager, hostname or queue!");
		throw new MQConnectionException("Fail to start "+this.getClass().getName()+" service");
	}
    try {
        boolean transacted = false;
    	QueueConnectionFactory factory = new MQQueueConnectionFactory();
      	((MQQueueConnectionFactory)factory).setQueueManager(this.getQueueManager());
      	((MQQueueConnectionFactory)factory).setTransportType(JMSC.MQJMS_TP_CLIENT_MQ_TCPIP);
      	((MQQueueConnectionFactory)factory).setHostName(this.getHostname());
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
    } catch (Exception e) {
	throw new MQConnectionException("Fail to start "+this.getClass().getName()+" service", e);
    }
  }


  public void stopService() throws MQConnectionException {
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
	throw new MQConnectionException("Fail to stop "+this.getClass().getName()+" service", e);
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
            LogManager.instance.logDebug(this.getClass().getName()+" try to reconnect :" + retryCounter);
            this.startService();
            reconnectSuccess = true;
      	}catch(Exception e){
            System.out.print(this.getClass().getName()+" reconnect failed");
      	}
      	retryCounter++;
	if(retryCounter>30 && !reconnectSuccess){ //send email after 5 minutes
		sleepTime = 5*60*1000;  //5 minutes;
		LogManager.instance.logDebug(this.getClass().getName()+" : Send email to help desk");
                /////////////////////////
		//TODO: sendMail2HelpDesk();
                /////////////////////////
	}

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