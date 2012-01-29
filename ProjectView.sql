select
case PI.OBJECTTYPE
  when 0 then 'Records'
  when 1 then 'Indexes'
  when 2 then 'Fields'
  when 3 then 'Field Formats'
  when 4 then 'Translate Values'
  when 5 then 'Pages'
  when 6 then 'Menus'
  when 7 then 'Components'
  when 8 then 'Record PeopleCode'
  when 9 then 'Menu PeopleCode'
  when 10 then 'Queries'
  when 11 then 'Tree Structures'
  when 12 then 'Trees'
  when 13 then 'Access Groups'
  when 14 then 'Colors'
  when 15 then 'Styles'
  when 16 then 'Business Process Maps'
  when 17 then 'Business Processes'
  when 18 then 'Activities'
  when 19 then 'Roles'
  when 20 then 'Process Definitions'
  when 21 then 'Servers Definitions'
  when 22 then 'Process Type Definitions'
  when 23 then 'Job Definitions'
  when 24 then 'Recurrence Definitions'
  when 25 then 'Message Catalog' -- ??
  when 26 then 'Dimensions'
  when 27 then 'Analysis Models'
  when 28 then 'Cube Templates'
  when 29 then 'Business Interlink'
  when 30 then 'SQL'
  when 31 then 'File Layout Definitions'
  when 32 then 'Component Interfaces'
  when 33 then 'Application Engine Programs'
  when 34 then 'Application Engine Sections'
  when 35 then 'Message Nodes'
  when 36 then 'Message Channels'
  when 37 then 'Messages'
  when 38 then 'Approval Rule Sets'
  when 39 then 'Message PeopleCode'
  when 40 then 'Subscription PeopleCode'
  when 41 then 'Channel PeopleCode'
  when 42 then 'Component Interface PeopleCode'
  when 43 then 'Application Engine PeopleCode'
  when 44 then 'Page PeopleCode'
  when 45 then 'Page Field PeopleCode'
  when 46 then 'Component PeopleCode'
  when 47 then 'Component Record PeopleCode'
  when 48 then 'Component Record Field PeopleCode'
  when 49 then 'Images'
  when 50 then 'Style Sheets'
  when 51 then 'HTML'
  when 52 then 'File References'
  when 53 then 'Permission Lists'
  when 54 then 'Portal Registry Definitions'
  when 55 then 'Portal Registry Structures'
  when 56 then 'URL Definitions'
  when 57 then 'Application Packages'
  when 58 then 'Application Package PeopleCode'
  when 59 then 'Portal Registry User Homepage'
  when 60 then 'Analytic Types'
  when 61 then 'Archive Template'
  when 62 then 'XSLT'
  when 63 then 'Portal Registry User Favorite'
  when 64 then 'Mobile Page'
  when 65 then 'Relationship'
  when 66 then 'CI Property PeopleCode'
  when 67 then 'Optimization Model'
  when 68 then 'File Reference'
  when 69 then 'File Reference Type Code'
  when 70 then 'Archive Object'
  when 71 then 'Archive Template (Type 2)'
  when 72 then 'Diagnostic Plug-In'
  when 73 then 'Analytic Model'
  when 75 then 'Java Portlet User Preference'
  when 76 then 'WSRP Remote Producer'
  when 77 then 'WSRP Remote Portlet'
  when 78 then 'WSRP Cloned Portlet Handle'
  when 79 then 'Service'
  when 80 then 'Service Operation'
  when 81 then 'Service Operation Handler'
  when 82 then 'Service Operation Version'
  when 83 then 'Service Operation Routing'
  when 84 then 'IB Queue'
  when 85 then 'XMLP Template Definition'
  when 86 then 'XMLP Report Definition'
  when 87 then 'XMLP File Definition'
  when 88 then 'XMLP Data Source Definition'
  when 89 then 'WSDL'
  when 90 then 'Message Schema'
  when 91 then 'Connected Query'
  when 92 then 'Document'
  when 93 then 'XML Document'
  when 94 then 'Relational Document'
  when 95 then 'Dependency Documents'
  when 97 then 'Essbase Cube Dimension'
  when 98 then 'Essbase Cube Outline'
  when 99 then 'Essbase Cube Connection'
  when 100 then 'Essbase Cube Template'
  when 101 then 'Delimited Document'
  when 102 then 'Positional Document'
  when 103 then 'Application Data Set Definition'
  when 104 then 'Tests'
  when 105 then 'Test Cases'
  else To_char(PI.OBJECTTYPE)
end                                        as "Object Type",
PI.OBJECTVALUE1                            as "Object Value 1",
case PI.OBJECTID2
  when 81 then case PI.OBJECTVALUE2
                 when '0' then 'Normal'
                 when '1' then 'Application Engine'
                 when '2' then 'Record View'
                 when '5' then 'Audit'
                 when '6' then 'App Engine XSLT'
                 else PI.OBJECTVALUE2
               end
  when 100 then case PI.OBJECTVALUE2
                  when 'C' then 'Content Ref.'
                  when 'F' then 'Folder'
                  when 'V' then 'Favorite'
                  else PI.OBJECTVALUE2
                end
  else PI.OBJECTVALUE2
end                                        as "Object Value 2",
PI.OBJECTVALUE3                            as "Object Value 3",
PI.OBJECTVALUE4                            as "Object Value 4",
Decode(PI.SOURCESTATUS, 0, 'Unknown',
                        1, 'Absent',
                        2, 'Changed',
                        3, 'Unchanged',
                        4, '*Changed',
                        5, '*Unchanged',
                        6, 'Same',
                        PI.SOURCESTATUS)   as "Source",
Decode(PI.TARGETSTATUS, 0, 'Unknown',
                        1, 'Absent',
                        2, 'Changed',
                        3, 'Unchanged',
                        4, '*Changed',
                        5, '*Unchanged',
                        6, 'Same',
                        PI.TARGETSTATUS)   as "Target",
Decode(PI.UPGRADEACTION, 0, 'Copy',
                         1, 'Delete',
                         2, 'None',
                         3, 'CopyProp',
                         PI.UPGRADEACTION) as "Action",
Decode(PI.TAKEACTION, 0, 'No',
                      1, 'Yes',
                      PI.TAKEACTION)       as "Take Action"
from   PSPROJECTITEM PI
where  PI.PROJECTNAME in ( 'DLP_COMPARE' )
-- AND  (PI.SOURCESTATUS IN (4,5) or PI.TARGETSTATUS IN (4,5))
order  by PI.OBJECTTYPE,
          PI.OBJECTVALUE1,
          PI.OBJECTVALUE2,
          PI.OBJECTVALUE3,
          PI.OBJECTVALUE4; 
