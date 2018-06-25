import java.util.*;
import javax.ejb.*;
import java.rmi.*;
import net.line.lcn.upm.adminApp.*;
import net.line.lcn.util.ldapUtil;
import net.line.lcn.upm.adminApp.dataobj.*;
import net.line.lcn.util.*;
import net.line.lcn.upm.*;
import javax.naming.*;
import javax.naming.directory.*;
import netscape.ldap.*;

/** This is a testing client program for UPMAdaptor.
 *  It also serves as a demostration program.
 */
public class testUPMAdaptor {

	public static void main( String args[] )	{
		UPMAdaptorHome		upmadaptorHome;
		UPMAdaptor			upmadaptor;
		LogonContext		lc;
		securityMgrHome		secMgrHome;
		securityMgr			_secMgr;
		int					i, j;
	
		// Create a connection to WebLogic
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
		env.put(Context.PROVIDER_URL, "t3://localhost:7001");
		
		if (args.length < 1)	{
			System.err.println( "Format: testLineAdmin orgID" );
			System.exit(1);
			}
		
		String		orgID = args[0];
		lc = new LogonContext( "hochoi.ho/" + orgID );
		
		try {		

			InitialContext ic = new InitialContext(env);
			upmadaptorHome = (UPMAdaptorHome) ic.lookup("net.line.lcn.upm.UPMAdaptor");
			upmadaptor = upmadaptorHome.create();

			System.out.println("Test Authentication by " + lc.getUid() + " for org " + orgID );
			System.out.println("------------------------------Test authenticate by -------------------------");
			upmadaptor.authenticate( "hochoi.ho", orgID, "password", false);
			
			System.out.println("------------------------------Test getOrg by orgID-------------------------------");		
			orgObject orgObj = upmadaptor.getOrg("testUPMAdaptor", orgID);	
			System.out.println( "upmadaptor.getOrg of " + orgID + ": " + orgObj );

			System.out.println("------------------------------Test getUser by pk -------------------------------");
			userObject userObj = upmadaptor.getUser("testUPMAdaptor", "hochoi.ho/" + orgID);	
			System.out.println( "upmadaptor.getUser of " + "hochoi.ho/" + orgID + ": " + userObj );

			System.out.println("------------------------------Test getUserGroup by pk--------------------------");
			userGroupObject userGroupObj = upmadaptor.getUserGroup("testUPMAdaptor", "Buyer/" + orgID);	
			System.out.println( "upmadaptor.getUserGroup of " + "Buyer/" + orgID + ": " + userGroupObj );

			System.out.println("------------------------------Test getOffice by pk-----------------------------");
			officeObject officeObj = upmadaptor.getOffice("testUPMAdaptor", "Tokyo/" + orgID);	
			System.out.println( "upmadaptor.getOffice of " + "Tokyo/" + orgID + ": " + officeObj );

			System.out.println("* * * * * * * * * * * *  Test getUserGroup by orgID and GID * * * * * * * * * * * * ");
			userGroupObject userGroupObj1 = upmadaptor.getUserGroup("testUPMAdaptor", orgID,"Buyer");	
			System.out.println( "upmadaptor.getuserGroup of " + orgID + " and Buyer" + ": " + userGroupObj1 );

			System.out.println("* * * * * * * * * * * *  Test getUser by orgID and UID * * * * * * * * * * * * ");
			userObject userObj1 = upmadaptor.getUser("testUPMAdaptor", orgID,"hochoi.ho");	
			System.out.println( "upmadaptor.getUser of " + orgID + " and hochoi.ho" + ": " + userObj1 );

			System.out.println("* * * * * * * * * * * *  Test getOffice by orgID and UID * * * * * * * * * * * * ");
			officeObject officeObj1 = upmadaptor.getOffice("testUPMAdaptor", orgID,"Tokyo");	
			System.out.println( "upmadaptor.getOffice of " + orgID + " and Tokyo" + ": " + officeObj1 );
			System.out.println("* * * * * * * * * * * *  Test searchUser * * * * * * * * * * * * ");
			
			Hashtable searchHT = new Hashtable();
			searchHT.put( "status", "PD" );		
			
			Vector sortVec = new Vector();
			sortVec.add( "uid" );
			sortVec.add( "givenname" );
			
			Vector userVec = upmadaptor.searchUser("testUPMAdaptor",  orgID, searchHT, sortVec, 0, 0 );
			if(!userVec.isEmpty()){
				for(int k=0;k<userVec.size();k++){
					System.out.println("uid="+((userObject)userVec.elementAt(k)).getUid());
				}
			}
			System.out.println("user count="+upmadaptor.searchUserCount("testUPMAdaptor", orgID,searchHT));
			
			System.out.println("* * * * * * * * * * * *  Test searchOrg * * * * * * * * * * * * ");
			
			searchHT = new Hashtable();
			searchHT.put( "status", "PD" );
		
			sortVec = new Vector();
			sortVec.add( "o" );
			sortVec.add( "name" );
			
			Vector orgVec = upmadaptor.searchOrg("testUPMAdaptor", searchHT, sortVec, 0, 0 );
			for(int k=0;k<orgVec.size();k++){
				System.out.println("o="+((orgObject)orgVec.elementAt(k)).getO());
			}
			System.out.println("org count="+upmadaptor.searchOrgCount("testUPMAdaptor", searchHT));

			System.out.println("* * * * * * * * * * * *  Test searchOffice * * * * * * * * * * * * ");
			
			searchHT = new Hashtable();
			searchHT.put( "locationRegion", "Asia" );
			
			sortVec = new Vector();
			sortVec.add( "locationRegion" );
			sortVec.add( "l" );
			
			Vector offVec = upmadaptor.searchOffice("testUPMAdaptor",  orgID, searchHT, sortVec, 0, 0 );
			for(int k=0;k<offVec.size();k++){
				System.out.println("l="+((officeObject)offVec.elementAt(k)).getL());
			}
			System.out.println("office count="+upmadaptor.searchOfficeCount("testUPMAdaptor", orgID,searchHT));
			
			System.out.println("* * * * * * * * * * * *  Test searchUserGroup * * * * * * * * * * * * ");
			
			searchHT = new Hashtable();
			searchHT.put( "category", "Sale" );
			
			sortVec = new Vector();
			sortVec.add( "category" );
			
			Vector userGroupVec = upmadaptor.searchUserGroup( "testUPMAdaptor", orgID, searchHT, sortVec, 0, 0 );
			for(int k=0;k<userGroupVec.size();k++){
				System.out.println("gid="+((userGroupObject)userGroupVec.elementAt(k)).getGid());
			}
			System.out.println("userGroup count="+upmadaptor.searchUserGroupCount("testUPMAdaptor", orgID,searchHT));
		} catch (UPMException ue) {
			System.out.println("---- UPMException ------------------");
			System.out.println("UPMException: " + ue );
		} catch (Exception e) {
			System.out.println("---- EXCEPTION ------------------");
			System.out.println("Exception: " + e );
		}
	}
}