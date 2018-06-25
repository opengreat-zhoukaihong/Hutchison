package src.test;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.util.Vector;
import org.apache.jasper.runtime.*;
import java.beans.*;
import org.apache.jasper.JasperException;
import net.line.fortress.apps.system.nls.*;


public class _0002fsrc_0002ftest_0002fJsp_00031_0002ejspJsp1_jsp_4 extends HttpJspBase {

    // begin [file="D:\\src\\test\\Jsp1.jsp";from=(3,0);to=(3,69)]
    // end

    static {
    }
    public _0002fsrc_0002ftest_0002fJsp_00031_0002ejspJsp1_jsp_4( ) {
    }

    private static boolean _jspx_inited = false;

    public final void _jspx_init() throws JasperException {
    }

    public void _jspService(HttpServletRequest request, HttpServletResponse  response)
        throws IOException, ServletException {

        JspFactory _jspxFactory = null;
        PageContext pageContext = null;
        HttpSession session = null;
        ServletContext application = null;
        ServletConfig config = null;
        JspWriter out = null;
        Object page = this;
        String  _value = null;
        try {

            if (_jspx_inited == false) {
                _jspx_init();
                _jspx_inited = true;
            }
            _jspxFactory = JspFactory.getDefaultFactory();
            response.setContentType("text/html;charset=8859_1");
            pageContext = _jspxFactory.getPageContext(this, request, response,
			"", true, 8192, true);

            application = pageContext.getServletContext();
            config = pageContext.getServletConfig();
            session = pageContext.getSession();
            out = pageContext.getOut();

            // HTML // begin [file="D:\\src\\test\\Jsp1.jsp";from=(0,0);to=(2,0)]
                out.write("<HTML>\r\n<HEAD>\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Jsp1.jsp";from=(2,56);to=(3,0)]
                out.write("\r\n");
            // end
            // begin [file="D:\\src\\test\\Jsp1.jsp";from=(3,0);to=(3,69)]
                test.Jsp1Bean Jsp1BeanId = null;
                boolean _jspx_specialJsp1BeanId  = false;
                 synchronized (session) {
                    Jsp1BeanId= (test.Jsp1Bean)
                    pageContext.getAttribute("Jsp1BeanId",PageContext.SESSION_SCOPE);
                    if ( Jsp1BeanId == null ) {
                        _jspx_specialJsp1BeanId = true;
                        try {
                            Jsp1BeanId = (test.Jsp1Bean) Beans.instantiate(getClassLoader(), "test.Jsp1Bean");
                        } catch (Exception exc) {
                             throw new ServletException (" Cannot create bean of class "+"test.Jsp1Bean");
                        }
                        pageContext.setAttribute("Jsp1BeanId", Jsp1BeanId, PageContext.SESSION_SCOPE);
                    }
                 } 
                if(_jspx_specialJsp1BeanId == true) {
            // end
            // begin [file="D:\\src\\test\\Jsp1.jsp";from=(3,0);to=(3,69)]
                }
            // end
            // HTML // begin [file="D:\\src\\test\\Jsp1.jsp";from=(3,69);to=(4,0)]
                out.write("\r\n");
            // end
            // begin [file="D:\\src\\test\\Jsp1.jsp";from=(4,0);to=(4,50)]
                JspRuntimeLibrary.introspect(pageContext.findAttribute("Jsp1BeanId"), request);
            // end
            // HTML // begin [file="D:\\src\\test\\Jsp1.jsp";from=(4,50);to=(13,0)]
                out.write("\r\n<TITLE>\r\nJsp1\r\n</TITLE>\r\n</HEAD>\r\n<BODY>\r\n<H1>\r\nJBuilder Generated JSP\r\n</H1>\r\n");
            // end
            // begin [file="D:\\src\\test\\Jsp1.jsp";from=(13,2);to=(29,0)]
                
                      MultilingualSystem.getInstance().setBaseName("Translation");
                      //Initialize FilePool
                      FilePool.getInstance();
                
                      //Define the default language and encoding ACCORDING TO THE USER PROFILE
                      //LogManager.instance.logInfo("LogManager Setting line.current.language and line.current.encoding");
                      //HttpSession session = event.getSession();
                      session.setAttribute("line.current.language", "en_CA");
                      //session.setAttribute("line.current.encoding", "big5");
                      //LogManager.instance.logInfo("MultilingualSystemListener.valueBound: end");
                      MultilingualSystem system = MultilingualSystem.getInstance();
                      system.setCharacterset(request,response);
                      LanguageBundleSystem localLabels = system.getLabels(session,"HIT");
                      out.println(localLabels.getProperty("Shipper ID"));
                      out.print(localLabels.getProperty("Billing"));
            // end
            // HTML // begin [file="D:\\src\\test\\Jsp1.jsp";from=(29,2);to=(37,27)]
                out.write("\r\n\r\n<FORM method=\"post\">\r\n<BR>Enter new value   :  <INPUT NAME=\"sample\"><BR>\r\n<BR><BR>\r\n<INPUT TYPE=\"SUBMIT\" NAME=\"Submit\" VALUE=\"Submit\">\r\n<INPUT TYPE=\"RESET\" VALUE=\"Reset\">\r\n<BR>\r\nValue of Bean property is :");
            // end
            // begin [file="D:\\src\\test\\Jsp1.jsp";from=(37,27);to=(37,82)]
                out.print(JspRuntimeLibrary.toString((((test.Jsp1Bean)pageContext.findAttribute("Jsp1BeanId")).getSample())));
            // end
            // HTML // begin [file="D:\\src\\test\\Jsp1.jsp";from=(37,82);to=(41,0)]
                out.write("\r\n</FORM>\r\n</BODY>\r\n</HTML>\r\n");
            // end

        } catch (Exception ex) {
            if (out.getBufferSize() != 0)
                out.clearBuffer();
            pageContext.handlePageException(ex);
        } finally {
            out.flush();
            _jspxFactory.releasePageContext(pageContext);
        }
    }
}
