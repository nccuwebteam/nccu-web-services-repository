<cfparam name='attributes.table' default='Registrations'>
<!---=====================================================
Example: <cf_getSpreadsheetOutput table='Registrations'>
=====================================================--->
<cfquery name='qrySelectRows'>
  SELECT
    *
  FROM
    #attributes.table#
</cfquery>
<!---=--->
<cfheader name='content-disposition' value='attachment; filename=spreadsheet.csv'>
<cfcontent type='text/csv'>
<!---=--->
<cfset tabChar = Chr(9)>
<cfset newLineChar = Chr(13) & Chr(10)>
<cfset columnNames = qrySelectRows.columnList>
<!---=--->
<cfoutput>
  <cfset vars.counter = 1>
  <cfloop list='#columnNames#' index='item'>#iif(vars.counter GT 1,DE(','),DE(''))##item#<cfset vars.counter += 1></cfloop>
  #newLineChar#
  <cfloop query='qrySelectRows'>
    <cfset vars.counter = 1>
    <cfloop list='#columnNames#' index='item'
      ><cfset vars.parsedItem = Replace(qrySelectRows[ListGetAt(columnNames,vars.counter)][qrySelectRows.currentRow],newLineChar,' ','all')
      ><cfset vars.parsedItem = Replace(vars.parsedItem,',',' ','all')
      >#iif(vars.counter GT 1,DE(','),DE(''))##vars.parsedItem
      #<cfset vars.counter += 1
      ></cfloop
    >
    #newLineChar#
  </cfloop>
</cfoutput>
