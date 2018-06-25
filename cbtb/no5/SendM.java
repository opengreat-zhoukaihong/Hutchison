

import com.ibm.mq.jms.MQConnectionFactory;
import com.ibm.mq.jms.MQQueueConnectionFactory;
import java.io.*;
import javax.jms.*;

public class SendM
{

    protected String mqManager;
    protected String hostname;
    protected String queue;
    protected int queueCCSID;
    protected QueueConnection connection;
    protected QueueSession session;
    protected Queue ioQueue;
    protected QueueSender queueSender;
    protected String XMLSourceURL;

    public SendM()
    {
        mqManager = "CARGONET.QM1";
        hostname = "187.11.1.125";
        queue = "CBT.IN.Q";
        queueCCSID = 1208;
        connection = null;
        session = null;
        ioQueue = null;
        queueSender = null;
        XMLSourceURL = null;
    }

    public static void main(String args[])
    {
        if(args.length != 1)
        {
            System.err.println("Usage: java SendM XMLSourceURL");
            SendM sendm = new SendM();
            sendm.setXMLSourceURL("d:\\cbtb_system\\cbtb_mq\\in04.txt");
            sendm.startSender();
            sendm.endSend();
            //System.exit(2);
        } else
        {
            SendM sendm = new SendM();
            sendm.setXMLSourceURL(args[0]);
            //sendm.setXMLSourceURL("d:\\cbtb_system\\cbtb_mq\\in01.txt");
            sendm.startSender();
            sendm.endSend();
        }
    }

    public void startSender()
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
            TextMessage textmessage = session.createTextMessage();
            queueSender = session.createSender(ioQueue);
            String s1 = "";
            try
            {
                DataInputStream datainputstream = new DataInputStream(new FileInputStream(getXMLSourceURL()));
                BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(datainputstream));
                String s;
                while((s = bufferedreader.readLine()) != null)
                    s1 = s1 + s;
            }
            catch(FileNotFoundException filenotfoundexception)
            {
                System.out.print("----no find file-----" + getXMLSourceURL() );
            }
            catch(IOException ioexception)
            {
                ioexception.printStackTrace();
            }
            System.out.println(s1);
            textmessage.setText(s1);
            queueSender.send(textmessage);
            System.out.println("------- success sender------");
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
            if(queueSender != null)
            {
                System.out.println("---------- Close " + getClass().getName() + " Queue Sender ----------");
                queueSender.close();
                queueSender = null;
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
                startSender();
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

    public void setXMLSourceURL(String s)
    {
        XMLSourceURL = s;
    }

    public String getXMLSourceURL()
    {
        return XMLSourceURL;
    }
}
