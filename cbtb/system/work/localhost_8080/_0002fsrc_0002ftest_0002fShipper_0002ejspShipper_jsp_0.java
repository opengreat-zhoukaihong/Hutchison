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
import net.line.fortress.apps.cbt.ejb.ShipperBean;
import net.line.fortress.apps.cbt.ejb.ShipperHome;
import net.line.fortress.apps.cbt.ejb.Shipper;
import javax.naming.*;
import java.util.Properties;
import javax.rmi.PortableRemoteObject;
import java.util.Collection;
import java.math.BigDecimal;
import java.util.Iterator;
import test.*;


public class _0002fsrc_0002ftest_0002fShipper_0002ejspShipper_jsp_0 extends HttpJspBase {

    // begin [file="D:\\src\\test\\Shipper.jsp";from=(13,0);to=(13,93)]
    // end

    static {
    }
    public _0002fsrc_0002ftest_0002fShipper_0002ejspShipper_jsp_0( ) {
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

            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(0,0);to=(2,0)]
                out.write("<HTML>\r\n<HEAD>\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(2,63);to=(3,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(3,63);to=(4,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(4,59);to=(5,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(5,35);to=(6,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(6,41);to=(7,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(7,51);to=(8,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(8,41);to=(9,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(9,41);to=(10,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(10,39);to=(11,0)]
                out.write("\r\n");
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(11,27);to=(12,0)]
                out.write("\r\n");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(12,0);to=(12,53)]
                JspRuntimeLibrary.introspect(pageContext.findAttribute("ShipperBeanId"), request);
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(12,53);to=(13,0)]
                out.write("\r\n");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(13,0);to=(13,93)]
                net.line.fortress.apps.cbt.ejb.ShipperBean bean0 = null;
                boolean _jspx_specialbean0  = false;
                 synchronized (session) {
                    bean0= (net.line.fortress.apps.cbt.ejb.ShipperBean)
                    pageContext.getAttribute("bean0",PageContext.SESSION_SCOPE);
                    if ( bean0 == null ) {
                        _jspx_specialbean0 = true;
                        try {
                            bean0 = (net.line.fortress.apps.cbt.ejb.ShipperBean) Beans.instantiate(getClassLoader(), "net.line.fortress.apps.cbt.ejb.ShipperBean");
                        } catch (Exception exc) {
                             throw new ServletException (" Cannot create bean of class "+"net.line.fortress.apps.cbt.ejb.ShipperBean");
                        }
                        pageContext.setAttribute("bean0", bean0, PageContext.SESSION_SCOPE);
                    }
                 } 
                if(_jspx_specialbean0 == true) {
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(13,0);to=(13,93)]
                }
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(13,93);to=(14,0)]
                out.write("\r\n");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(14,0);to=(14,45)]
                JspRuntimeLibrary.introspect(pageContext.findAttribute("bean0"), request);
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(14,45);to=(15,0)]
                out.write("\r\n");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(15,2);to=(27,0)]
                
                
                   try {
                    ShipperTestClient1 client = new ShipperTestClient1();
                    Shipper shipper = client.findByPrimaryKey("ENSIGN");
                    ShipperBean sbean = shipper.getDetails();
                    bean0 = sbean;
                    } catch (Exception e) {
                      e.printStackTrace();
                    }
                
                
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(27,2);to=(47,37)]
                out.write("\r\n\r\n\r\n\r\n<TITLE>\r\nShipper\r\n</TITLE>\r\n</HEAD>\r\n<BODY>\r\n<H1>\r\nJBuilder Generated JSP\r\n</H1>\r\n<FORM method=\"post\">\r\n<BR>Enter new value   :  <INPUT NAME=\"sample\"><BR>\r\n<BR><BR>\r\n<INPUT TYPE=\"SUBMIT\" NAME=\"Submit\" VALUE=\"Submit\">\r\n<INPUT TYPE=\"RESET\" VALUE=\"Reset\">\r\n<BR>\r\n<HR>bean0<BR>\r\nEnter new value for bean0.creditLineAmount :  <INPUT NAME=\"creditLineAmount\"><BR>\r\nValue of bean0.creditLineAmount is : ");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(47,37);to=(47,97)]
                out.print(JspRuntimeLibrary.toString((((net.line.fortress.apps.cbt.ejb.ShipperBean)pageContext.findAttribute("bean0")).getCreditLineAmount())));
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(47,97);to=(49,28)]
                out.write("<BR>\r\nEnter new value for bean0.details :  <INPUT NAME=\"details\"><BR>\r\nValue of bean0.details is : ");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(49,28);to=(49,79)]
                out.print(JspRuntimeLibrary.toString((((net.line.fortress.apps.cbt.ejb.ShipperBean)pageContext.findAttribute("bean0")).getDetails())));
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(49,79);to=(51,35)]
                out.write("<BR>\r\nEnter new value for bean0.entityContext :  <INPUT NAME=\"entityContext\"><BR>\r\nValue of bean0.organizationId is : ");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(51,35);to=(51,93)]
                out.print(JspRuntimeLibrary.toString((((net.line.fortress.apps.cbt.ejb.ShipperBean)pageContext.findAttribute("bean0")).getOrganizationId())));
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(51,93);to=(53,33)]
                out.write("<BR>\r\nEnter new value for bean0.paymentTerms :  <INPUT NAME=\"paymentTerms\"><BR>\r\nValue of bean0.paymentTerms is : ");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(53,33);to=(53,89)]
                out.print(JspRuntimeLibrary.toString((((net.line.fortress.apps.cbt.ejb.ShipperBean)pageContext.findAttribute("bean0")).getPaymentTerms())));
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(53,89);to=(55,28)]
                out.write("<BR>\r\nEnter new value for bean0.webSite :  <INPUT NAME=\"webSite\"><BR>\r\nValue of bean0.webSite is : ");
            // end
            // begin [file="D:\\src\\test\\Shipper.jsp";from=(55,28);to=(55,79)]
                out.print(JspRuntimeLibrary.toString((((net.line.fortress.apps.cbt.ejb.ShipperBean)pageContext.findAttribute("bean0")).getWebSite())));
            // end
            // HTML // begin [file="D:\\src\\test\\Shipper.jsp";from=(55,79);to=(60,0)]
                out.write("<BR>\r\n<HR><BR>\r\n</FORM>\r\n</BODY>\r\n</HTML>\r\n");
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
