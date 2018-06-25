package com.cbtb.mq;

/**
 * Title:        Receiver  ibm MQSeries message and deal with them<br>
 * Description: This class is a application.The application is a thread for
 * receiveing and dealing with MQseries messages.<br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:      HT<br>
 * @author Henry Mei
 * @version 1.0
 */

 /**
  * This application is a method to start receive thread as a MQSeries message monitor.
  */
  public class CBTMessageSet{
  /**MQ recevier thread status*/
  private String MQStatus="STOP";
  CBTMQReceviver messageThread =new  CBTMQReceviver();
  public void startMQThread(){
  CBTMQReceviver messageThread =new  CBTMQReceviver(1000);
  messageThread.setName("CBTMQ");
  messageThread.setPriority(3);
  //System.out.println(messageThread.getName());
  messageThread.start();
  this.setMQStatus("STARTING");
  }

   public void setMQStatus(String theMQStatus){
      this.MQStatus=theMQStatus;
   }

   public String getMQStatus(){
     return this.MQStatus;
   }

  public CBTMessageSet(){
  }
   static  public void main(String[] args) {
   CBTMessageSet mSet=new CBTMessageSet();
   mSet.startMQThread();
   }
  }
/**
 * Thread for listener MQSeries message.When message is coming.The program auto deal with them according their type.
 */
  class CBTMQReceviver extends Thread {
  private int delay;
  private  boolean messageReceive;

   public CBTMQReceviver(){
   }
   public  CBTMQReceviver(int d){
     this.setMessageReceive(true);
     CBTMQListener listener =new CBTMQListener();
     this.delay=d;
   }
   public synchronized void run(){
     while(this.isMessageReceive()){
     try{
      sleep(delay);
      }catch(InterruptedException e){
      System.out.println(e.getMessage());
      LogManager.instance.logDebug(e.getMessage());
      }
      }
    }

/**Set message receive status*/
  public void setMessageReceive(boolean newMessageReceive)
  {
    messageReceive = newMessageReceive;
  }
/**Get message recive status*/
  public boolean isMessageReceive()
  {
    return messageReceive;
  }
/**Clean up resources*/
  public void destroy()
  {
  }
}