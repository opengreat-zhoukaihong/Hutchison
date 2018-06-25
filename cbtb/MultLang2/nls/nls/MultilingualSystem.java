package net.line.fortress.apps.system.nls;

import net.line.fortress.apps.system.LogManager;
import javax.servlet.http.*;
import java.util.*;
import net.line.fortress.apps.system.nls.*;
import javax.naming.*;

public class MultilingualSystem {
  private static String BASE_NAME = "";
  private static MultilingualSystem instance = null;

  public static MultilingualSystem getInstance() {
    if (instance== null)
        createInstance();
    return instance;
  }

  private static synchronized void createInstance() {
    if (instance == null)
      instance = new MultilingualSystem();
  }

  public void setBaseName(String name) {
    this.BASE_NAME = name;
  }

  public LanguageBundleSystem getLabels(HttpSession session, String projectCode){
      LanguageBundleSystem lb = null;
      String currentLang = null;
      String sessionLang = null;
      Hashtable htl =null;
      try{
          if ((Hashtable) session.getAttribute("line.languages")==null) {
            htl = new LanguageBundleSession();
            session.setAttribute("line.languages",htl);
          } else {
            htl = (Hashtable) session.getAttribute("line.languages");
          }

          sessionLang =(String) session.getAttribute("line.current.language");
          LogManager.instance.logInfo("MultilingualSystem.getLabels(): baseName=" + BASE_NAME + "  currentLanguage="+sessionLang+"  projectCode="+projectCode);
          currentLang = BASE_NAME+"_"+(String) session.getAttribute("line.current.language")+"_"+projectCode;
          if(htl.containsKey(currentLang)){
              lb = (LanguageBundleSystem)htl.get(currentLang);
          }else{
              lb = new LanguageBundleSystem(this.BASE_NAME,sessionLang,projectCode);
              htl.put(currentLang, lb);
          }
          return lb;
      }catch(Exception e){
          LogManager.instance.logError("Error In MultilingualSystem.getLabels: ",e);
          return null;
      }
  }

  public void setLanguage(HttpSession session, String code) {
      InitialContext ctx = null;
      try {
        ctx = new InitialContext();
        LogManager.instance.logInfo("MultilingualSystem.setLanguage(): code = " + code.trim());
        session.setAttribute("line.current.language", code.trim());
        LanguageServiceHome home = (LanguageServiceHome)javax.rmi.PortableRemoteObject.narrow(
              ctx.lookup("nls.LanguageService"), LanguageServiceHome.class);
        LanguageService service = home.create();
        session.setAttribute("line.current.encoding", service.getEncoding(code.trim()));
        service.remove();

      } catch (Exception e) {
          LogManager.instance.logError("Error in MultilingualSystem.setLanguage: ",e);
      } finally {
        try {
          ctx.close();
        } catch (Exception e) {}
      }
  }


  public void setCharacterset(HttpServletRequest request, HttpServletResponse response) {
      HttpSession session = request.getSession();
      String type = (String)session.getAttribute("line.current.encoding");
      LogManager.instance.logInfo("MultilingualSystem.setCharacterset(): type = " + type);
      response.setContentType("text/html; charset=" + type);
  }
}