

import com.ibm.mq.jms.MQConnectionFactory;
import com.ibm.mq.jms.MQQueueConnectionFactory;
import java.io.PrintStream;
import javax.jms.*;

public class GetM
{

    protected String mqManager;
    protected String hostname;
    protected String queue;
    protected int queueCCSID;
    protected QueueConnection connection;
    protected QueueSession session;
    protected Queue ioQueue;
    protected QueueReceiver queueReceiver;
    String receivedMessage;

    public GetM()
    {
        mqManager = "CARGONET.QM1";
        hostname = "187.11.1.125";
        queue = "CBT.IN.Q";
        queueCCSID = 1208;
        connection = null;
        session = null;
        ioQueue = null;
        queueReceiver = null;
        receivedMessage = null;
    }

    public void startReceiver()
    {
        if(mqManager == null || hostname == null || queue == null)
        {
            System.out.println("Error in " + getClass().getName() + ": haven't define MQ manager, hostname or queue!");
            System.out.println("Fail to start " + getClass().getName() + " service");
        }
        try
        {
            boolean flag = false;
            MQQueueConnectionFactory mqqueueconnectionfactory = new MQQueueConnectionFactory();
            ((MQQueueConnectionFactory)mqqueueconnectionfactory).setQueueManager(getQueueManager());
            ((MQQueueConnectionFactory)mqqueueconnectionfactory).setTransportType(1);
            ((MQQueueConnectionFactory)mqqueueconnectionfactory).setHostName(getHostname());
            ((MQQueueConnectionFactory)mqqueueconnectionfactory).setCCSID(queueCCSID);
            connection = mqqueueconnectionfactory.createQueueConnection();
            connection.start();
            System.out.println("------- connection start------");
            session = connection.createQueueSession(flag, 1);
            ioQueue = session.createQueue(queue);
            queueReceiver = session.createReceiver(ioQueue);
            javax.jms.Message message = queueReceiver.receive(1000L);
            receivedMessage = ((TextMessage)message).getText();
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            System.out.println("Received Message from MQ Listener: <" + receivedMessage + ">");
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        }
        catch(Exception exception)
        {
            System.out.println("Fail to start " + getClass().getName() + " service:" + exception);
        }
    }

    public void stopS()
    {
        try
        {
            if(queueReceiver != null)
            {
                System.out.println("---------- Close " + getClass().getName() + " Queue Sender ----------");
                queueReceiver.close();
                queueReceiver = null;
            }
            if(session != null)
            {
                System.out.println("---------- Close " + getClass().getName() + " Queue Session ----------");
                session.close();
                session = null;
            }
            if(connection != null)
            {
                System.out.println("---------- Close " + getClass().getName() + " MQ Connection ----------");
                connection.close();
                connection = null;
            }
        }
        catch(Exception exception)
        {
            System.out.println("Fail to stop " + getClass().getName() + " service" + exception);
        }
    }

    public void setQueueManager(String s)
    {
        mqManager = s;
    }

    public String getQueueManager()
    {
        return mqManager;
    }

    public void setHostname(String s)
    {
        hostname = s;
    }

    public String getHostname()
    {
        return hostname;
    }

    public void setQueue(String s)
    {
        queue = s;
    }

    public String getQueue()
    {
        return queue;
    }

    public void onException(JMSException jmsexception)
    {
        boolean flag = false;
        int i = 0;
        int j = 10000;
        while(!flag)
        {
            try
            {
                Thread.sleep(j);
                System.out.println(getClass().getName() + " try to reconnect :" + i);
                startReceiver();
                flag = true;
            }
            catch(Exception exception)
            {
                System.out.print(getClass().getName() + " reconnect failed");
            }
            if(++i > 30 && !flag)
            {
                j = 0x493e0;
                System.out.println(getClass().getName() + " : Send email to help desk");
            }
        }
    }

    public void endSend()
    {
        try
        {
            stopS();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    public static void main(String args[])
    {
        GetM getm = new GetM();
        getm.startReceiver();
        getm.endSend();
    }
}
