// *** Generated Source File - Do Not Edit - Changes Will Be Lost ***

package net.line.fortress.apps.system.report;

// IM_Ag_
import java.util.Locale;
import java.sql.*;
import net.line.fortress.apps.system.security.*;
import net.line.fortress.apps.system.utils.SQLUtil;
import net.line.fortress.apps.system.utils.DefaultConnectionPool;

public class ReportFactory
{

	// ------ Declarations ------
	// DC_Ag_
	  private static String SELECT_REPORT_PREFERENCE =
	    "select report_id, system_name, report_name, default_format, " +
	    "default_language, default_encoding from report";
	  private static String SELECT_USER_REPORT_PREFERENCE =
	    "select user_id, report_id, report_format, report_language, " +
	    "report_encoding from user_report_preference";
	  private static String SELECT_ORG_REPORT_PREFERENCE =
	    "select org_id, report_id, report_format, report_language, " +
	    "report_encoding from org_report_preference";


	// ------ Instance Variables ------
	// ---- Begin SilverStream User-Written Event Handler Methods ----
	// ----

	// ------ Public methods ------

	// UC_Ag_
	  private static Connection getConnection() throws SQLException {
	    return DefaultConnectionPool.getInstance().getConnection();
	  }

	  private static void releaseConnection(Connection connection) {
            //
	  }

	  // this function is obsoleted, no locale defined would cause confusion
	  /*public ReportSpec getReportSpec(String systemName, String reportName) {
	    return new ReportSpec(systemName, reportName);
	  }*/

	  // this function not support report preference
	  public static ReportSpec getReportSpec(String systemName, String reportName, Locale locale) {
	    return getReportSpec(systemName, reportName, ReportSpec.PDF, locale);
	  }

	  // this function not support report preference
	  public static ReportSpec getReportSpec(String systemName, String reportName, int format, Locale locale) {
	    String encoding = "UTF8";
	    if (format == ReportSpec.PDF) {
	      if (Locale.TRADITIONAL_CHINESE.equals(locale)) {
	        encoding = "BIG5";
	      } else if (Locale.SIMPLIFIED_CHINESE.equals(locale)) {
	        encoding = "GBK";
	      }
	    }
	    return new ReportSpec(systemName, reportName, format, locale, encoding, null);
	  }

	  // if preference not found in user_report_preference
	  // then choose preference in org_report_preference table
	  public static ReportSpec getReportSpecByUser(String reportId, User user) throws ReportException {
	    return getReportSpecByUser(reportId, user.getUserID(), user.getDomainID());
	  }

	  private static ReportSpec setPreference(ReportSpec reportSpec, String language, String format, String encoding) {
	        Locale locale = Locale.ENGLISH;

	        if ("EN".equalsIgnoreCase(language)) {
	          locale = Locale.ENGLISH;
	        } else if ("ZH".equalsIgnoreCase(language)) {
	          locale = Locale.TRADITIONAL_CHINESE;
	        } else if ("CN".equalsIgnoreCase(language)) {
	          locale = Locale.SIMPLIFIED_CHINESE;
	        }

	        if (locale != null) {
	          reportSpec.setLocale(locale);
	        }

	        int reportFormat = -1;

	        if ("PDF".equalsIgnoreCase(format)) {
	          reportFormat = ReportSpec.PDF;
	        } else if ("EXCEL".equalsIgnoreCase(format)) {
	          reportFormat = ReportSpec.EXCEL;
	        } else if ("TEXT".equalsIgnoreCase(format)) {
	          reportFormat = ReportSpec.TEXT;
	        } else if ("HTML".equalsIgnoreCase(format)) {
	          reportFormat = ReportSpec.HTML;
	        } else if ("POSTSCRIPT".equalsIgnoreCase(format)) {
	          reportFormat = ReportSpec.POSTSCRIPT;
	        } else if ("RTF".equalsIgnoreCase(format)) {
	          reportFormat = ReportSpec.RTF;
	        }

	        if (reportFormat != -1) {
	          reportSpec.setFileFormat(reportFormat);
	        }

	        if (encoding != null) {
	          reportSpec.setEncoding(encoding);
	        }

	        return reportSpec;
	  }

	  // if preference not found in user_report_preference
	  // then choose preference in report table
	  public static ReportSpec getReportSpecByUser(String reportId, String userId) throws ReportException {
	    return getReportSpecByUser(reportId, userId, null);
	  }

	  // if preference not found in user_report_preference
	  // then choose preference in report table
	  private static ReportSpec getReportSpecByUser(String reportId, String userId, String organizationId) throws ReportException {
	      boolean found = false;
	      ReportSpec reportSpec = getReportSpec(reportId);
	      Connection connection = null;
	      PreparedStatement pStmt = null;
	      ResultSet rSet = null;
	      String reportQuery = SELECT_USER_REPORT_PREFERENCE + " where report_id = ? and user_id = ?";

	      try {
	        connection = getConnection();
	        pStmt = connection.prepareStatement(reportQuery);
	        pStmt.setString(1, reportId);
	        pStmt.setString(2, userId);
	        rSet = pStmt.executeQuery();
	        if (rSet.next()) {
	          String language = SQLUtil.getNullString(rSet, "report_language", null);
	          String format = SQLUtil.getNullString(rSet, "report_format", null);
	          String encoding = SQLUtil.getNullString(rSet, "report_encoding", null);
	          setPreference(reportSpec, language, format, encoding);
	          found = true;
	        }
	      } catch (SQLException e) {
                  e.printStackTrace();
//	              LogManager.instance.logError("Unable to getReportSpec() for " + reportId + " in user_report_preference table for user:" + userId, e);
	      } finally {
	          if (rSet != null) {
	            try {
	                    rSet.close();
	            } catch (SQLException e) {
                      e.printStackTrace();
//	                    LogManager.instance.logError("Unable to close the rSet.", e);
	            }
	          }
	          if (pStmt != null) {
	            try {
	                    pStmt.close();
	            } catch (SQLException e) {
                        e.printStackTrace();
//	                    LogManager.instance.logError("Unable to close the pStmt.", e);
	            }
	          }
	          if (connection != null) {
	            releaseConnection(connection);
	          }
	      }
	      if (!found && organizationId != null) {
	        return getReportSpecByOrganization(reportId, organizationId);
	      }
	      return reportSpec;
	  }

	  public static ReportSpec getReportSpecByOrganization(String reportId, String organizationId) throws ReportException {
	      ReportSpec reportSpec = getReportSpec(reportId);
	      Connection connection = null;
	      PreparedStatement pStmt = null;
	      ResultSet rSet = null;
	      String reportQuery = SELECT_ORG_REPORT_PREFERENCE + " where report_id = ? and org_Id = ?";

	      try {
	        connection = getConnection();
	        pStmt = connection.prepareStatement(reportQuery);
	        pStmt.setString(1, reportId);
	        pStmt.setString(2, organizationId);
	        rSet = pStmt.executeQuery();
	        if (rSet.next()) {
	          String language = SQLUtil.getNullString(rSet, "report_language", null);
	          String format = SQLUtil.getNullString(rSet, "report_format", null);
	          String encoding = SQLUtil.getNullString(rSet, "report_encoding", null);
	          setPreference(reportSpec, language, format, encoding);
	        }

	      } catch (SQLException e) {
                      e.printStackTrace();
//	              LogManager.instance.logError("Unable to getReportSpec() for " + reportId + " in org_report_preference table for organization:" + organizationId, e );
	      } finally {
	          if (rSet != null) {
	            try {
	                    rSet.close();
	            } catch (SQLException e) {
                            e.printStackTrace();
//	                    LogManager.instance.logError("Unable to close the rSet.", e);
	            }
	          }
	          if (pStmt != null) {
	            try {
	                    pStmt.close();
	            } catch (SQLException e) {
                            e.printStackTrace();
//	                    LogManager.instance.logError("Unable to close the pStmt.", e);
	            }
	          }
	          if (connection != null) {
	            releaseConnection(connection);
	          }
	      }
	      return reportSpec;
	  }

	  public static ReportSpec getReportSpec(String reportId) throws ReportException {
	      ReportSpec reportSpec = null;
	      Connection connection = null;
	      PreparedStatement pStmt = null;
	      ResultSet rSet = null;
	      String reportQuery = SELECT_REPORT_PREFERENCE + " where report_id = ?";

	      try {
	        connection = getConnection();
	        pStmt = connection.prepareStatement(reportQuery);
	        pStmt.setString(1, reportId);
	        rSet = pStmt.executeQuery();
	        if (!rSet.next()) {
	              throw new ReportException("No record found for report preference " + reportId + " in report table");
	        }
	        String defaultLanguage = SQLUtil.getNullString(rSet, "default_language", null);
	        Locale locale = Locale.ENGLISH;

	        if ("ZH".equalsIgnoreCase(defaultLanguage)) {
	          locale = Locale.TRADITIONAL_CHINESE;
	        } else if ("CN".equalsIgnoreCase(defaultLanguage)) {
	          locale = Locale.SIMPLIFIED_CHINESE;
	        }

	        String defaultFormat = SQLUtil.getNullString(rSet, "default_format", null);
	        int format = ReportSpec.PDF;
	        if ("HTML".equalsIgnoreCase(defaultFormat)) {
	          format = ReportSpec.HTML;
	        } else if ("TEXT".equalsIgnoreCase(defaultFormat)) {
	          format = ReportSpec.TEXT;
	        } else if ("EXCEL".equalsIgnoreCase(defaultFormat)) {
	          format = ReportSpec.EXCEL;
	        } else if ("POSTSCRIPT".equalsIgnoreCase(defaultFormat)) {
	          format = ReportSpec.POSTSCRIPT;
	        } else if ("RTF".equalsIgnoreCase(defaultFormat)) {
	          format = ReportSpec.RTF;
	        }

	        reportSpec = new ReportSpec(
	                SQLUtil.getNullString(rSet, "system_name", null),
	                SQLUtil.getNullString(rSet, "report_name", null),
	                format, locale,
	                SQLUtil.getNullString(rSet, "default_encoding", null), null);
	      } catch (SQLException e) {
//	              LogManager.instance.logError("Unable to getReportSpec() for " + reportId, e);
	              throw new ReportException("Unable to getReportSpec() for " + reportId);
	      } finally {
	          if (rSet != null) {
	            try {
	                    rSet.close();
	            } catch (SQLException e) {
//	                    LogManager.instance.logError("Unable to close the rSet.", e);
	            }
	          }
	          if (pStmt != null) {
	            try {
	                    pStmt.close();
	            } catch (SQLException e) {
//	                    LogManager.instance.logError("Unable to close the pStmt.", e);
	            }
	          }
	          if (connection != null) {
	            releaseConnection(connection);
	          }
	      }

	      return reportSpec;
	  }

}
