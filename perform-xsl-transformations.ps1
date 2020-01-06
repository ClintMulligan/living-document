# This script reads a CSV and uses the values as inputs to the 
# XslCompiledTransform XSL processor.
#
# We use it here to generate a living document. A compilation of files from data
# to presentation, that can be viewed by modern browsers (Internet Explorer
# is not a modern browser). The resulting HTML can be sent as-is and when opened
# in a browser will have benefits of CSS and inline Javascript. Allowing for
# reports to be consistent style, built in filtering, calculations, and react to
# user interactions (such as sort, hide, expand, ect).
# 
# @params
# csvPathname = local CSV file.
# strDelimiter = Delimiter used in csv.
# blComments = True if using comments.
# strComment = Character denoting comments.
# blHeaders = True if using a header.
# blDebug = Outputs values to console for testing purposes.
#
# @version 0.0.1
# @author Clinton Mulligan

# Might be useful solving a permission problem.
# If files are marked un-trusted from the Zip. The user can manually trust each
# file or Mark unblocked before unzipping package. To bypass this user
# interaction we tell Powershell to mark all the files in this directory (folder)
# as trusted to run.
# Get-ChildItem -Recurse | Unblock-File

# If receiving Error "File xxxx cannot be loaded because the execution of
# scripts is disabled on this system":
# Run Powershell as Administrator, then input:
# set-executionpolicy remotesigned

# Assuming a CSV with a similar look to:
# XmlDoc, XslSheet, Output File, Argument 1, Argument 2
# # comment
# input/content.xml, input/stylesheet.xsl, output/result.foo, lang=en-US, my-param=my-thing

$csvPathname = "xsl-transformation-params.csv"
$strDelimiter = ","
$blComments = $true
$strComment = "#"
$blHeaders = $true
$blDebug = $false

# Additional Settings for XSLT
$allowDocumentFunction = 1
$allowScripts = 0


If ($blComments -AND $blHeaders) {
  If ($blDebug) {
    "First Case Found; Comments:True Headers:True"
  }
  $csv = Get-Content $PSScriptRoot\$csvPathname |
  Where-Object { !$_.StartsWith($strComment) } |
  ConvertFrom-Csv –Delimiter $strDelimiter
}

If ($blComments -AND !$blHeaders) {
  If ($blDebug) {
    "Second Case Found; Comments:True Headers:False"
  }
  $csv = Get-Content $PSScriptRoot\$csvPathname |
  Where-Object { !$_.StartsWith($strComment) } |
  ConvertFrom-Csv –Delimiter $strDelimiter -Header placeholderA, placeholderB, placeholderC
}

If (!$blComments -AND $blHeaders) {
  If ($blDebug) {
    "Third Case Found; Comments:False Headers:True"
  }
  $csv = Import-Csv –Delimiter $strDelimiter $PSScriptRoot\$csvPathname
}

If (!$blComments -AND !$blHeaders) {
  If ($blDebug) {
    "Fourth Case Found; Comments:False Headers:False"
  }
  $csv = Import-Csv –Delimiter $strDelimiter -Header Column One, Column Two, Column Three, Column Arg1, Column Arg2 $PSScriptRoot\$csvPathname
}

# Put Headers into an Array to give handle to column positions.
$columns = $csv[0].psobject.Properties | ForEach-Object { $_.Name }

ForEach ($item in $csv) {
  # Assign variables to each column position, located by header name.
  $doc = $item.($columns[0])
  $sheet = $item.($columns[1])
  $output = $item.($columns[2])
  $argument1 = $item.($columns[3])
  $argument2 = $item.($columns[4])

  # Check if XSLT Parameter Columns are "null" string.
  # If not create an array of name-value pair.
  If ($argument1.ToLower() -eq "null") {
    $argument1 = $Null
  } Else {
    $argument1 = $argument1 -split "="
  }
  
  If ($argument2.ToLower() -eq "null") {
    $argument2 = $Null
  } Else {
    $argument2 = $argument2 -split "="
  }

  # Output to Console the values being used (debug true).
  If ($blDebug) {
    "Headers: " + ($columns -join ", ")
    Write-Output "document = $doc"
    Write-Output "stylesheet = $sheet"
    Write-Output "result = $output"
    "param = $argument1"
    "param = $argument2"
  }
  
  # Resolve relative paths in csv to this script's current location.
  $strXmlPathname = $PSScriptRoot + "\" + $doc
  $strXslPathname = $PSScriptRoot + "\" + $sheet
  $strOutputPathname = $PSScriptRoot + "\" + $output

  # Settings for XSLT Processor.
  $xslt_settings = New-Object System.Xml.Xsl.XsltSettings
  $xslt_settings.EnableDocumentFunction = $allowDocumentFunction
  $xslt_settings.EnableScript = $allowScripts

  # Prepare an Argument List for the processor to pass 0 to 2 Parameters to Stylesheet.
  [System.Xml.Xsl.XsltArgumentList]$argList = [System.Xml.Xsl.XsltArgumentList]::new()
  If ($argument1) {
    $argList.AddParam($argument1[0], "", $argument1[1])
  }

  If ($argument2) {
    $argList.AddParam($argument2[0], "", $argument2[1])
  }

  # Settings for XML Writer.
  $xml_settings = New-Object System.Xml.XmlWriterSettings
  $xml_settings.Indent = $true
  $xml_settings.IndentChars = "  "

  # Because of Windows... the XML Writer ignore the omit-xml-declaration attribute
  # in the XSL.
  # To weakly patch for this, we will create a Document (always includes xml declaration)
  # for outputs like XML, and a Fragment (never includes xml declaration for all else). 
  $last_three = $strOutputPathname.Substring($strOutputPathname.Length - 3)
  If ($last_three -eq "xsl" -OR $last_three -eq "xml") {
    $xml_settings.ConformanceLevel = "Document"
  } Else {
    # Some transformations are fragments with out root xml node.
    $xml_settings.ConformanceLevel = "Fragment"
  }

  # Prepare XML Writer to write output to a created file at the Output Pathname.
  $xmlWriter = [System.XML.XmlWriter]::Create($strOutputPathname, $xml_settings)

  # Basic Resolver for DTDs, import, and include xslt functions.
  # Of interest; how to pass credentials when fetching some external assets.
  # Of interest; XmlSecureResolver
  $XmlUrlResolver = New-Object System.Xml.XmlUrlResolver

  # Create the XSLT Processor, Load XSL, settings and Resolver.
  $proc = New-Object System.Xml.Xsl.XslCompiledTransform
  $proc.Load($strXslPathname, $xslt_settings, $XmlUrlResolver)

  # Perform tranform using XML Writer as result destination.
  $proc.Transform($strXmlPathname, $argList, $xmlWriter)

  # Close the Writer and output file.
  $xmlWriter.Close()
}

If ($blDebug) {
  # Start-Sleep 10
  # or
  Pause
}

