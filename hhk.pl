#perl -n

# /a name="(.+?)"/ && print $1' index.html | sort -u | 

chomp;
print "\t<LI> <OBJECT type=\"text/sitemap\">\n";
print "\t\t<param name=\"Keyword\" value=\"$_\">\n";
print "\t\t<param name=\"Local\" value=\"index.html#$_\">\n";
print "\t\t</OBJECT>\n";

