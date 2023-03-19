@Release_15.0@Report@Web@Group_Player_Archival
Feature: OL_AR_Scheduled_Player_Archives Validate the Scheduled Player Archives header with Permission 'Checks'

#******************************************************************************************************
#** Feature File                    : OL_AR_Scheduled_Player_Archives
#** Feature Name                    : Validate the Scheduled Player Archives header with Permission 'Checks'
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 459427,459449,470500,470641,470650
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  11/07/2022           Ajay Dahiya              Initial Draft
#**************************************************************************************************/
Scenario:001  - Validate the Scheduled Player Archives header with Permission 'Checks'(TC ID 459427,459449,470500,470641,470650)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	#Navigate to Group Permission
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "REPORTSCHEDULEDPLAYERARCHIVES" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks ARCHIVEPLAYER Permisison is Unchecked.
	Then User "Checks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value                         |
		| permissionname | REPORTSCHEDULEDPLAYERARCHIVES |
	When User waits "2" seconds
	#User verifies Description and Catgory of Permission
	Then User verifies attribute "innerText" value "ALLOWS USER TO VIEW SCHEDULED PLAYER ARCHIVES REPORT" of element "lylGroup_Permission.mic_desc_text"
	Then User verifies attribute "innerText" value "Reports" of element "lylGroup_Permission.mic_category_text"
	#User save permission
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds
	When User "refresh" the browser
	#Navigate to Report
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Scheduled Player Archives" in "OLW_Reports.txt_ReportSearch"
	Given User clicks on "OLW_Reports.Dropdown_FilterAndSelectReport" with parameters
		| Key        | Value                     |
		| ReportName | Scheduled Player Archives |
	#'Selected Property' is present on Page
	Then User verifies that element "OLW_Schdle_Plyr_Arch.txt_Player_Property" is present "true" on UI
	#Click on launch button
	Given User clicks on "OLW_Reports.btn_Launch"
	When User waits "2" seconds
	#Switch to another window tab( Means new window popped on )
	When User switches to browser tab "1"
	When User waits "2" seconds
	#Verify the report Title
	Then User verifies that element "OLW_Schdle_Plyr_Arch.txt_Scheduled_Player_Archives" is present "true" on UI
	#Verify in Details Header Private column has added
	Then User verifies that element "OLW_Schdle_Plyr_Arch.tbl_Details_Column" is present "true" on UI with parameters
		| Key                | Value              |
		| Universal_ID       | Universal ID       |
		| Player_Name        | Player Name        |
		| Property           | Property           |
		| Last_Activity_date | Last Activity date |
		| Bucket_Name        | Bucket Name        |
		| Bucket_Balance     | Bucket Balance     |

Scenario:002  - Validate the Scheduled Player Archives header without Permission will not be available(TC ID 470500)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	#Navigate to Group Permission
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "REPORTSCHEDULEDPLAYERARCHIVES" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks ARCHIVEPLAYER Permisison is Unchecked.
	Then User "Unhecks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value                         |
		| permissionname | REPORTSCHEDULEDPLAYERARCHIVES |
	When User waits "2" seconds
	#User verifies Description and Catgory of Permission
	Then User verifies attribute "innerText" value "ALLOWS USER TO VIEW SCHEDULED PLAYER ARCHIVES REPORT" of element "lylGroup_Permission.mic_desc_text"
	Then User verifies attribute "innerText" value "Reports" of element "lylGroup_Permission.mic_category_text"
	#User save permission
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds
	When User "refresh" the browser
	#Navigate to Report
	Given User enters text "Reports" in "lylMAIN_NAV_BOX.txtSearch_Box"
	Given User clicks on "lylMAIN_NAV_BOX.lnk_Side_SubMenu" with parameters
		| Key         | Value   |
		| SideSubMenu | Reports |
	When User waits "2" seconds
	#Search Report
	Given User enters text "Scheduled Player Archives" in "OLW_Reports.txt_ReportSearch"
	Then User verifies that element "OLW_Reports.Dropdown_FilterAndSelectReport" is present "false" on UI with parameters
		| Key        | Value                     |
		| ReportName | Scheduled Player Archives |

Scenario: 003 Renabling 'REPORTSCHEDULEDPLAYERARCHIVES' Permission
	#User login to web-app
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "2" seconds
	Given User clicks on "MAIN_NAV_BOX.GROUP_PERMISSIONS_LINK"
	#User navigate to ARCHIVEPLAYER permission under Group Permission
	Given User selects option "<#Halo_ADGroup_1#>" of element "USER_GROUP_PERMISSIONS.USER_GROUP_DROPDOWN" by "visibletext"
	Given User clicks on "USER_GROUP_PERMISSIONS.EDIT_FUNCTIONS_BUTTON"
	Given User clears "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User enters text "REPORTSCHEDULEDPLAYERARCHIVES" in "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_TEXTBOX"
	Given User clicks on "USER_GROUP_PERMISSIONS.PERMISSION_SEARCH_BUTTON"
	#User checks ARCHIVEPLAYER Permisison is Unchecked.
	Then User "Checks" element "USER_GROUP_PERMISSIONS.PERMISSION_NAME_CHECKBOX" with parameters
		| Key            | Value                         |
		| permissionname | REPORTSCHEDULEDPLAYERARCHIVES |
	#User save permission
	When User waits "1" seconds
	When User scrolls till element "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	Given User clicks on "USER_GROUP_PERMISSIONS.SAVE_BUTTON"
	When User waits "2" seconds