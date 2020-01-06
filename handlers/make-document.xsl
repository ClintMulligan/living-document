<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.w3.org/1999/xhtml" 
  xmlns:ns="https://www.armirage.com/examples/living-document">

  <xsl:output method="html" version="5.0" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
  <xsl:strip-space elements="*" />

  <xsl:param name="target-language" />
  <xsl:param name="target-theme" />

  <xsl:variable name="output-language">
    <!-- See if target-language has been set if not use default. -->
    <xsl:choose>
      <xsl:when test="string-length($target-language) > 0">
        <xsl:value-of select="$target-language" />
      </xsl:when>
      <xsl:otherwise>en-US</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

    <xsl:variable name="output-theme">
    <!-- See if theme has been set if not use default. -->
    <xsl:choose>
      <xsl:when test="string-length($target-theme) > 0">
        <xsl:value-of select="$target-theme" />
      </xsl:when>
      <xsl:otherwise>default-report-theme</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="text()">
    <xsl:value-of disable-output-escaping="yes" select="normalize-space()" />
  </xsl:template>

  <xsl:param name="project-name" select="ns:project/ns:meta/ns:project-name" />
  <xsl:param name="client" select="ns:project/ns:meta/ns:client" />

  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>
          <xsl:value-of select="$project-name" />
          <xsl:text> | </xsl:text>
          <xsl:value-of select="$client" />
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <xsl:call-template name="insertFragment">
          <xsl:with-param name="insertType">style</xsl:with-param>
        </xsl:call-template>
      </head>
      <body>
        <nav id="menu">
          <ul class="topnav">
            <li>
              <a href="#mainContent">
                <var name="AID0T1C0A">
                  <!-- skip to main content. -->
                  <xsl:call-template name="lookupL10nString">
                    <xsl:with-param name="language" select="$output-language" />
                    <xsl:with-param name="var-id">AID0T1C0A</xsl:with-param>
                  </xsl:call-template>
                </var>
              </a>
            </li>
            <li>
              <a href="#">
                <var name="AID0TGD0A">
                  <!-- Goto top of page. -->
                  <xsl:call-template name="lookupL10nString">
                    <xsl:with-param name="language" select="$output-language" />
                    <xsl:with-param name="var-id">AID0TGD0A</xsl:with-param>
                  </xsl:call-template>
                </var>
              </a>
            </li>
            <li>
              <a href="#copyright">
                <var name="AID0TQD0A">
                  <!-- Goto bottom of page. -->
                  <xsl:call-template name="lookupL10nString">
                    <xsl:with-param name="language" select="$output-language" />
                    <xsl:with-param name="var-id">AID0TQD0A</xsl:with-param>
                  </xsl:call-template>
                </var>
              </a>
            </li>
          </ul>
        </nav>

        <header>
          <h1>
            <xsl:value-of select="$project-name" />
            <xsl:text> | </xsl:text>
            <xsl:value-of select="$client" />
          </h1>
        </header>

        <main id="mainContent">
          <xsl:apply-templates />
        </main>

        <aside>
          <xsl:text><!-- Put Aside sections here. Like charts and graphs. --> </xsl:text>
        </aside>

        <section id="copyrightInfo">
          <span id="copyright">Copyright © 2020 Clinton Mulligan - All Rights Reserved</span>
        </section>

        <xsl:call-template name="insertFragment">
          <xsl:with-param name="insertType">script</xsl:with-param>
        </xsl:call-template>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="ns:meta">
  </xsl:template>

  <xsl:template match="ns:tasks">
    <table id="mainTable" class="">
      <thead id="tableHead">
        <tr>
          <th>
            <var name="AID0T4E0A">
              <!-- Department -->
              <xsl:call-template name="lookupL10nString">
                <xsl:with-param name="language" select="$output-language" />
                <xsl:with-param name="var-id">AID0T4E0A</xsl:with-param>
              </xsl:call-template>
            </var>
          </th>
          <th>
            <var name="AID0TDF0A">
              <!-- Task -->
              <xsl:call-template name="lookupL10nString">
                <xsl:with-param name="language" select="$output-language" />
                <xsl:with-param name="var-id">AID0TDF0A</xsl:with-param>
              </xsl:call-template>
            </var>
          </th>
          <th>
            <var name="AID0TJF0A">
              <!-- Status -->
              <xsl:call-template name="lookupL10nString">
                <xsl:with-param name="language" select="$output-language" />
                <xsl:with-param name="var-id">AID0TJF0A</xsl:with-param>
              </xsl:call-template>
            </var>
          </th>
          <th>
            <var name="AID0TNH0A">
              <!-- Start date -->
              <xsl:call-template name="lookupL10nString">
                <xsl:with-param name="language" select="$output-language" />
                <xsl:with-param name="var-id">AID0TNH0A</xsl:with-param>
              </xsl:call-template>
            </var>
          </th>
          <th>
            <var name="AID0TPF0A">
              <!-- Due date -->
              <xsl:call-template name="lookupL10nString">
                <xsl:with-param name="language" select="$output-language" />
                <xsl:with-param name="var-id">AID0TPF0A</xsl:with-param>
              </xsl:call-template>
            </var>
          </th>
        </tr>
      </thead>
      <tbody id="tableBody">
        <xsl:apply-templates />
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="ns:task">
    <tr>
      <xsl:attribute name="task-id">
        <xsl:value-of select="@task-id" />
      </xsl:attribute>
      <xsl:apply-templates />
    </tr>
  </xsl:template>

  <xsl:template match="ns:team">
    <td>
      <xsl:apply-templates />
    </td>
  </xsl:template>

  <xsl:template match="ns:description">
    <td>
      <xsl:apply-templates />
    </td>
  </xsl:template>

  <xsl:template match="ns:percent-complete">
    <td>
      <progress max="100">
        <xsl:attribute name="value">
          <xsl:value-of select="." />
        </xsl:attribute>
        <xsl:value-of select="." />
      </progress>
    </td>
  </xsl:template>

  <xsl:template match="ns:start-date">
    <td>
      <xsl:apply-templates />
    </td>
  </xsl:template>

  <xsl:template match="ns:due-date">
    <td>
      <xsl:apply-templates />
    </td>
  </xsl:template>

  <xsl:template match="*[local-name()='var']">
    <var>
      <xsl:attribute name="name">
        <xsl:value-of select="@name" />
      </xsl:attribute>
      <xsl:call-template name="lookupL10nString">
        <xsl:with-param name="language" select="$output-language" />
        <xsl:with-param name="var-id" select="@name" />
      </xsl:call-template>
    </var>
  </xsl:template>

  <!-- Named Templates -->

  <!-- Lookup l10n Translation String -->
  <xsl:template name="lookupL10nString">
    <xsl:param name="var-id" />
    <xsl:param name="language" />

    <!-- Lowercase transform for lang ISO code. -->
    <xsl:variable name="filename" select="translate($language,'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />

    <xsl:variable name="path" select="document(concat('../models/l10n/', $filename, '.xml'))/xliff/file/body/trans-unit[@id=$var-id]/target" />
    <xsl:value-of select="$path" />
  </xsl:template>

  <!-- Insert HTML Fragments -->
  <xsl:template name="insertFragment">
    <!-- One or the other for external document --> 
    <xsl:param name="insertPathname" /> 
    <xsl:param name="insertType" />

    <xsl:choose>

      <xsl:when test="$insertType ='script'">
        <script type="text/javascript" id="reportScript">
          <xsl:value-of disable-output-escaping="yes" select="document(concat('../views/', $output-theme, '/script.html'))/wrapper/*" />
        </script>
      </xsl:when>

      <xsl:when test="$insertType ='style'">
        <style id="reportStyle">
          <xsl:value-of disable-output-escaping="yes" select="document(concat('../views/', $output-theme, '/style.html'))/wrapper/*" />
        </style>
      </xsl:when>

      <xsl:otherwise>
        <xsl:copy-of select="document($insertPathname)/wrapper/*" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>