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

/** This is a testing client program for UPMUpdateAdaptor.
 *  It also serves as a demostration program.
 */
public class testUPMUpdateAdaptor {

	public static void main( String args[] )	{

		UPMUpdateAdaptorHome upmupdateadaptorHome;
		UPMUpdateAdaptor	 upmupdateadaptor;

		int					i, j;
		
		String		userID = null;
		String		orgID = null;
		String		offID = null;
		String		gID	= null;
		
		// Create a connection to WebLogic
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
		env.put(Context.PROVIDER_URL, "t3://localhost:7001");
	
		/* Check arguement list */	
		if (args.length < 3)	{
			System.err.println( "Format: testUPMUpdateAdaptor dataObject testcase PK" );
			System.err.println( "[dataObject: 1-User, 2-Organization, 3-Office, 4-UserGroup]" );
			System.err.println( "[testcase: 1-Create, 2-Update, 3-Delete]" );
			System.exit(1);
			}
		
		int		doType = Integer.parseInt(args[0]);
		int		testcase = Integer.parseInt(args[1]);
		String	pkStr = args[2];
		
		switch (doType) {
			case 1: 
				userID = pkStr.substring( 0, pkStr.indexOf('/'));
				orgID = pkStr.substring( pkStr.indexOf('/')+1);
				break;
			case 2: 
				orgID = pkStr;
				break;
			case 3: 
				offID = pkStr.substring( 0, pkStr.indexOf('/'));
				orgID = pkStr.substring( pkStr.indexOf('/')+1);
				break;
			case 4: 
				gID = pkStr.substring( 0, pkStr.indexOf('/'));
				orgID = pkStr.substring( pkStr.indexOf('/')+1);
				break;
		}
		
		testcase = (doType * 10) + testcase;
		
		userHome			userh;
		user				user1;
		userObject			userObj1;
		
		organizationHome	orgh;
		organization		org1;
		orgObject			orgObj1;
		
		officeHome			offh;
		office				off1;
		officeObject		offObj1;
		
		userGroupHome		userGrouph;
		userGroup			userGroup1;
		userGroupObject		userGroupObj1;

		try {		

			InitialContext ic = new InitialContext(env);
			upmupdateadaptorHome = (UPMUpdateAdaptorHome) ic.lookup("net.line.lcn.upm.UPMUpdateAdaptor");
			upmupdateadaptor = upmupdateadaptorHome.create();
						
			switch (testcase) {		
			case 11:	
				System.out.println("------------------------------Test Create User-------------------------------");		
				userObject usrObj = new userObject();
				usrObj.setUid(userID+"/"+orgID);
				usrObj.setO(orgID);
				usrObj.setCn(userID);	
				usrObj.setSn("Surname for "+userID);
				usrObj.setGivenName("Given name for "+userID);
				usrObj.setCreator("testUPMUPDATEAdaptor");	
				usrObj.setOffice("Line-HK"+"/"+orgID);
				usrObj.setStatus("NL");
				usrObj.setStatusLastModifyBy("testUPMUPDATEAdaptor");
				usrObj.setTimeZone(0);	
				usrObj.setAdminLevel(1);
				usrObj.setUserPassword("123456");
			
				upmupdateadaptor.createUser("testUPMUPDATEAdaptor", usrObj);	
						
				System.out.println( "User Created ! " );
			
				userh = (userHome) ic.lookup("net.line.lcn.upm.adminApp.user");
			
				if (userh == null)	{
					System.out.println("userh is null" );
				}

				/* Reading existing Entry */
				user1 = userh.findByPrimaryKey( userID + "/" + orgID  );
				userObj1 = user1.getDO();	
			
				System.out.println( "Created Values : " + userObj1 );	
				System.out.println("------------------------------Test Create User-------------------------------");		
				break;
				
			case 12:	
				System.out.println("------------------------------Test Update User-------------------------------");		
				
				userh = (userHome) ic.lookup("net.line.lcn.upm.adminApp.user");
			
				if (userh == null)	{
					System.out.println("userh is null" );
				}
				/* Reading existing Entry */
				user1 = userh.findByPrimaryKey( userID + "/" + orgID  );
				userObj1 = user1.getDO();	
				
				userObj1.setSn("Updated Surname for "+userID);
				userObj1.setGivenName("Updated Given name for "+userID);
				userObj1.setStatus("PD");
			
				upmupdateadaptor.updateUser("testUPMUPDATEAdaptor", userObj1);	
						
				System.out.println( "User Updated ! " );
			
				System.out.println( "Updated Values : " + userObj1 );	
				System.out.println("------------------------------Test Update User-------------------------------");		
				break;
				
			case 13:	
				System.out.println("------------------------------Test Delete User-------------------------------");						
						
				upmupdateadaptor.deleteUser("testUPMUPDATEAdaptor", userID + "/" + orgID);	
						
				System.out.println( "User Deleted ! " );

				System.out.println("------------------------------Test Delete User-------------------------------");		
				break;
				
			case 21:	
				System.out.println("------------------------------Test Create Organization-------------------------------");		
				orgObject orgObj = new orgObject();
				orgObj.setO(orgID);
				orgObj.setName("Organization Name for " + orgID);
				orgObj.setCreator("testUPMUPDATEAdaptor");	
				orgObj.setStatus("NL");
				orgObj.setStatusLastModifyBy("testUPMUPDATEAdaptor");
				orgObj.setDefaultUserPasswordExpiry(0);
			
				upmupdateadaptor.createOrg("testUPMUPDATEAdaptor", orgObj);	
						
				System.out.println( "Organization Created ! " );
			
				orgh = (organizationHome) ic.lookup("net.line.lcn.upm.adminApp.organization");
			
				if (orgh == null)	{
					System.out.println("orgh is null" );
				}
				/* Reading existing Entry */
				org1 = orgh.findByPrimaryKey( orgID  );
				orgObj1 = org1.getDO();	
			
				System.out.println( "Created Values : " + orgObj1 );	
				System.out.println("------------------------------Test Create Organization-------------------------------");		
				break;
					
			case 22:	
				System.out.println("------------------------------Test Update Organization-------------------------------");		
				
				orgh = (organizationHome) ic.lookup("net.line.lcn.upm.adminApp.organization");
			
				if (orgh == null)	{
					System.out.println("orgh is null" );
				}
				/* Reading existing Entry */
				org1 = orgh.findByPrimaryKey( orgID  );
				orgObj1 = org1.getDO();	
				
				orgObj1.setName("Updated Name for "+ orgObj1.getName());
				orgObj1.setStatus("PD");
			
				upmupdateadaptor.updateOrg("testUPMUPDATEAdaptor", orgObj1);	
						
				System.out.println( "Organization Updated ! " );
				System.out.println( "Updated Values : " + orgObj1 );	
				System.out.println("------------------------------Test Update Organization-------------------------------");		
				break;
				
			case 23:	
				System.out.println("------------------------------Test Delete Organization-------------------------------");						
						
				upmupdateadaptor.deleteOrg("testUPMUPDATEAdaptor", orgID);	
						
				System.out.println( "Organization Deleted ! " );

				System.out.println("------------------------------Test Delete Organization-------------------------------");		
				break;
			
			case 31:	
				System.out.println("------------------------------Test Create Office-------------------------------");		
				officeObject offObj = new officeObject();
				offObj.setO(orgID);
				offObj.setL(offID+"/"+orgID);
				offObj.setCreator("testUPMUPDATEAdaptor");	
				offObj.setStatus("NL");
				offObj.setStatusLastModifyBy("testUPMUPDATEAdaptor");
				offObj.setOfficeHierLevel(3);
				offObj.setLocationRegion("Asia");
				offObj.setLocationCountry("OS1");
				offObj.setDescription("A Testing Remark for Description");
			
				upmupdateadaptor.createOffice("testUPMUPDATEAdaptor", offObj);	
						
				System.out.println( "Office Created ! " );
			
				offh = (officeHome) ic.lookup("net.line.lcn.upm.adminApp.office");
			
				if (offh == null)	{
					System.out.println("offh is null" );
				}
				/* Reading existing Entry */
				off1 = offh.findByPrimaryKey( offID + "/" + orgID  );
				offObj1 = off1.getDO();	
			
				System.out.println( "Created Values : " + offObj1 );	
				System.out.println("------------------------------Test Create Office-------------------------------");		
				break;	
			
			case 32:	
				System.out.println("------------------------------Test Update Office-------------------------------");		
				
				offh = (officeHome) ic.lookup("net.line.lcn.upm.adminApp.office");
			
				if (offh == null)	{
					System.out.println("offh is null" );
				}
				/* Reading existing Entry */
				off1 = offh.findByPrimaryKey( offID + "/" + orgID  );
				offObj1 = off1.getDO();	
				
				offObj1.setDescription("Updated [ "+offObj1.getDescription()+" ]");
				offObj1.setStatus("SP");
			
				upmupdateadaptor.updateOffice("testUPMUPDATEAdaptor", offObj1);	
						
				System.out.println( "Office Updated ! " );
			
				System.out.println( "Updated Values : " + offObj1 );	
				System.out.println("------------------------------Test Update Office-------------------------------");		
				break;
				
			case 33:	
				System.out.println("------------------------------Test Delete Office-------------------------------");						
						
				upmupdateadaptor.deleteOffice("testUPMUPDATEAdaptor", offID + "/" + orgID);	
						
				System.out.println( "Office Deleted ! " );

				System.out.println("------------------------------Test Delete Office-------------------------------");		
				break;	
				
			case 41:	
				System.out.println("------------------------------Test Create User Group-------------------------------");		
				userGroupObject usrGroupObj = new userGroupObject();
				usrGroupObj.setGid(gID+"/"+orgID);
				usrGroupObj.setO(orgID);
				usrGroupObj.setCn("Testing Group Name for [ " + gID + "/" + orgID + " ]");	
				usrGroupObj.setCreator("testUPMUPDATEAdaptor");	
				usrGroupObj.setStatus("NL");
				usrGroupObj.setStatusLastModifyBy("testUPMUPDATEAdaptor");
				
				Vector owner = new Vector();
				owner.add("jim.lai/" + orgID);
				owner.add("globaadmin2/" + orgID);
				usrGroupObj.setOwner(owner);
				
				Vector member = new Vector();
				member.add("jim.lai/" + orgID);
				member.add("ray.lam/" + orgID);
				member.add("taiwanadmin/" + orgID);
				usrGroupObj.setUniqueMember(member);
			
				upmupdateadaptor.createUserGroup("testUPMUPDATEAdaptor", usrGroupObj);	
						
				System.out.println( "User Group Created ! " );
			
				userGrouph = (userGroupHome) ic.lookup("net.line.lcn.upm.adminApp.userGroup");
			
				if (userGrouph == null)	{
					System.out.println("userGrouph is null" );
				}
				/* Reading existing Entry */
				userGroup1 = userGrouph.findByPrimaryKey( gID + "/" + orgID  );
				userGroupObj1 = userGroup1.getDO();	
			
				System.out.println( "Created Values : " + userGroupObj1 );	
				System.out.println("------------------------------Test Create User Group-------------------------------");		
				break;
					
			case 42:	
				System.out.println("------------------------------Test Update User Group-------------------------------");		
				
				userGrouph = (userGroupHome) ic.lookup("net.line.lcn.upm.adminApp.userGroup");
			
				if (userGrouph == null)	{
					System.out.println("userGrouph is null" );
				}
				/* Reading existing Entry */
				userGroup1 = userGrouph.findByPrimaryKey( gID + "/" + orgID  );
				userGroupObj1 = userGroup1.getDO();					
				
				userGroupObj1.setCn("Updated : " + userGroupObj1.getCn() );
				userGroupObj1.setStatus("PD");
			
				upmupdateadaptor.updateUserGroup("testUPMUPDATEAdaptor", userGroupObj1);	
						
				System.out.println( "User Group Updated ! " );
			
				System.out.println( "Updated Values : " + userGroupObj1 );	
				System.out.println("------------------------------Test Update User Group-------------------------------");		
				break;
				
			case 43:	
				System.out.println("------------------------------Test Delete User Group-------------------------------");						
						
				upmupdateadaptor.deleteUserGroup("testUPMUPDATEAdaptor", gID + "/" + orgID);	
						
				System.out.println( "User Group Deleted ! " );

				System.out.println("------------------------------Test Delete User Group-------------------------------");		
				break;
				
			default:
				System.out.println("INVALID DataObject/Testcase combination.");		
				break;
			}
			
		} catch (UPMException ue) {
			System.out.println("---- UPMException ------------------");
			System.out.println("UPMException: " + ue );
		} catch (Exception e) {
			System.out.println("---- EXCEPTION ------------------");
			System.out.println("Exception: " + e );
		}
	}
}