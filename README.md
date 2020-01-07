## From <img src="docs/images/armirage-logo.svg" alt="Armirage company logo. An 'A' shaped leaf with the internal silhouette shaped like a person." style="width:30px;"> ARMIRAGE

## Living Document

> It’s OK to figure out murder mysteries, but you shouldn’t need to figure out code. You should be able to read it.<br>
> -- [Steve McConnell](https://www.amazon.com/Code-Complete-Practical-Handbook-Construction/dp/0735619670)

Hopefully the following code is easy to understand. I commented each of the files and using this readme as a roadmap to
what files to read next. To execute the creation of the Living-Document run the "perform-xsl-transformations.ps1" script.

## Table of contents
* [Documentation](#documentation)

## Documentation

Start at the lowest layer, Data. Find in the "models" folder two sub-folders marked "content" and another "l10n".

"l10n" is short hand for localization. Refers to translating displayed strings into local languages and format. The 
language files make up a kind of dictionary, referenced by XSL when the document is created.

To begin making the living document I draft a complete web page. A single file containing HTML, Data, Javascript and CSS.

I then extrapolate the Data into an XML file to act as Source of Truth. But also easy to extend as a message recieved from an external service. This will be /models/content/project-one.xml

(I draft DTD and XSD at this point as well for any later validation needed.)

I wrap any consistent reccuring string that will be translated with <var name="A"> tags. I only include a collision character and use name instead of "id". I have a different script that goes through the XML and XSL replacing these <var>s with unique hashes as IDs.

I create a default theme under views. In that folder I put the external files (CSS and JS) that will be copied into the report as it's theme. 

Whats left is create an XSL that will transform the XML data into the HTML page including the appropriate theme, and referencing the appropriate l10n files.

A Powershell script, is provided to perform the transformations. But any XSL processor written in other languages can be used just as easily. (maybe even easier than powershell).
