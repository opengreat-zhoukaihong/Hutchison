package com.cbtb.mq;

/**
 * Title:     CBTMQStart<br>
 * Description:  This class is a servlet for receive  ibm MQSeries messages
 * and deal with them.It  invoke CBTMessageSet's startMQThread method.<br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:      HT<br>
 * @author Henry Mei
 * @version 1.0
 */

import javax.servlet.*;
import java.io.*;
import java.util.*;

public class CBTMQStart extends GenericServlet
{
  private static final String CONTENT_TYPE = "text/html";
  CBTMessageSet mSet=new CBTMessageSet();
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
  }
  public void service(ServletRequest req,ServletResponse res)
              throws ServletException,IOException
  {
    ServletOutputStream out = res.getOutputStream();
    if(mSet.getMQStatus().equalsIgnoreCase("STOP")){
    out.println("Starting MQ Listener......");
    mSet.startMQThread();
    if(mSet.getMQStatus().equalsIgnoreCase("STARTING"))
    out.println("...Now ,MQ Listener is runing");
    }else{
    out.println("MQ Listener have run");
    }

  }
  /**Clean up resources*/
  public void destroy()
  {
  }
}
