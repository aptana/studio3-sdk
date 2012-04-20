#!/usr/bin/perl -w

# Kevin Lindsey
# 25/Aug/2010

# This script consumes the output from running an XML file against
# list_elements.xsl.  It assumes the output has been sorted and reduced to
# unique entries only. Element names must preceed child and attribute entries.
#
# This script transforms the output into a XSLT stylesheet that effectively
# clones the XML that list_elements.xsl was run against. The resulting
# stylesheet explicitly copies attributes and matches children. Thus, the
# stylesheet can be used as a starting point when transforming one XML format
# to another

my %elements;

# build intermediate element list with attributes and children
while (<>) {
	chomp;
	
	next if /^\s*$/;
	
	if (/^([^>]+)>(.+)$/) {
		push @{$elements{$1}->{children}}, $2;
	} elsif (/^([^@]+)@(.+)$/) {
		push @{$elements{$1}->{attributes}}, $2;
	} else {
		$elements{$_} = {attributes => [], children => []};
	}
}

# output cloning stylesheet
print <<EOS;
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.1">

<xsl:output method="xml" indent="yes"/>
EOS

foreach my $name ( sort keys %elements ) {
	print "\n";
	print "<xsl:template match=\"$name\">\n";

	my $element = $elements{$name};
	my $attrs = $element->{attributes};
	my $children = $element->{children};

	if (@$attrs or @$children) {
		
		print "  <xsl:copy>\n";

		if (@$attrs) {
			foreach my $attr (@$attrs) {
				print "    <xsl:apply-templates select=\"\@$attr\"/>\n";
			}
		}
	
		if (@$children) {
			foreach my $child (@$children) {
				print "    <xsl:apply-templates select=\"$child\"/>\n";
			}
		}
		
		print "  </xsl:copy>\n";
	} else {
		print "  <xsl:copy-of select=\".\"/>\n";
	}
	
	print "</xsl:template>\n";
}

print <<EOS;

<xsl:template match="@*">
  <xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
EOS

