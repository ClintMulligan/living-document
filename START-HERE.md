## From <img src="docs/images/armirage-logo.svg" alt="Armirage company logo. An 'A' shaped leaf with the internal silhouette shaped like a person." style="width:30px;"> ARMIRAGE

## Living Document

> It’s OK to figure out murder mysteries, but you shouldn’t need to figure out code. You should be able to read it.<br>
> -- [Steve McConnell](https://www.amazon.com/Code-Complete-Practical-Handbook-Construction/dp/0735619670)

Hopefully the following code is easy to understand. I commented each of the files and using this readme as a roadmap to
what files to read next. To execute the creation of the Living-Document run the "perform-xsl-transformations.ps1" script.

## Table of contents
* [Documentation](#documentation)

## Documentation

Start at the lowest layer, Data. You will find in the "models" folder two sub-folders marked "content" and another "l10n".
"l10n" is short hand for localization, and refers to translating displayed strings into local languages and format. The 
language files make up a kind of dictionary referenced when the document is created.

To begin making the living document I draft a complete web page. A single file containing my HTML, Data, Javascript and CSS.

I then extrapolate the Data into an XML file to act a Source of Truth. This will be /models/content/project-one.xml
The DTD and XSD are also created for drafting any later validation needed.

At this time I add <var name="A"> tags around strings intended to translated into other languages. I only include a collision character and use name instead of "id".
Because many of the strings are repeated through out the page.

I create a default theme under views, and extrapolate the CSS Styles and Javascript into that sub-folder.

Whats left is create an XSL that will transform the XML data into the HTML page including the appropriate theme, and referencing the appropriate l10n files.
