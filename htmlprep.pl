#!/usr/bin/perl -w
use strict;
# split into version specific parts, and create expandable images for older versions
open I, "<", "index-work.html" or die;
my @HTML = qw(index.html index-8.html index-10.html index-12.html index-14.html index-18.html);
chmod 0644, @HTML;
open O, ">", "index.html" or die;
open O8, ">", "index-8.html" or die;
open O10, ">", "index-10.html" or die;
open O12, ">", "index-12.html" or die;
open O14, ">", "index-14.html" or die;
open O18, ">", "index-18.html" or die;
my %png = map { $_ => 1 } <*.png>;
my $from = qr/(?:<p>)?<center><img src="(.+)\.png"><\/center>/;

#my $to = '<div align="center"><span class="i58" id="svnull-8"><a name="svnull-8" onclick="javascript:Toggle(\'svnull-8\')"><span title="Click to hide">Until 5.8:</span><img class="i58" src="svnull-8.png" alt="svnull 5.8"></a></span><span class="i514" id="svhead"><a href="#svnull-8" onclick="javascript:Toggle(\'svnull-8\')"><span title="Click to show other">Since 5.10:<img src="svhead.png" alt="_SV_HEAD 5.10"></span></a></span></div>';

while (<I>) {
  my ($do58, $do510, $do512, $do514, $do518) = (0,0,0,0,0);
  if (/span.i58, span.i510 {display: none;}/) {
    print O;
    my $s = $_;
    $s =~ s/span.i58, span.i510 {display: none;}/span.i58, span.i510 {display: inline;}/;
    print O8  $s;
    print O10 $s;
    print O12 $s;
    print O14 $s;
    print O18 $s;
    next;
  }
  if (m|for perl 5.20 and older</small></h1>|) {
    print O;
    my $s = $_;
    $s =~ s/for perl 5.20 and older/for perl 5.8 and older/;
    print O8 $s;
    $s =~ s/for perl 5.8 and older/for perl 5.10/;
    print O10 $s;
    $s =~ s/for perl 5.10/for perl 5.12/;
    print O12 $s;
    $s =~ s/for perl 5.12/for perl 5.14 to 5.16/;
    print O14 $s;
    $s =~ s/for perl 5.14 to 5.16/for perl 5.18/;
    print O18 $s;
    next;
  }
  if (m|<title>PerlGuts Illustrated</title>|) {
    s|<title>PerlGuts Illustrated</title>|<title>PerlGuts Illustrated</title>\n<!-- Generated, do not edit! Edit index-work.html instead -->|;
  }
  if (m/ are now included in this single document, but also available/) {
    print O;
    my $s = $_;
    $s =~ s/ are now included in this single document, but also available/ are available/;
    print O8 $s;
    print O10 $s;
    print O12 $s;
    print O14 $s;
    print O18 $s;
    next;
  }
  if (/$from/) {
    my $png = $1;
    $do58++  if $png{$png."-8.png"};
    $do510++ if $png{$png."-10.png"};
    $do512++ if $png{$png."-12.png"};
    $do514++ if $png{$png."-14.png"};
    $do518++ if $png{$png."-18.png"};
    if ($png{$png.".png"} and !($do58 or $do510 or $do514 or $do518)) {
      s/$from/<center><img src="$png\.png" alt="$png"><\/center>/; # keep it, just add alt=$png
      print O8;
      print O10;
      print O12;
      print O14;
      print O18;
    } else {
      $_ = '<div align="center">';
      if ($do58 and $do510 and $do514 and $do518) {
        print O8 $_."<img class=\"i58\" src=\"$png-8.png\" alt=\"$png 5.8\">"."</div>\n";
        print O10 $_."<img class=\"i510\" src=\"$png-10.png\" alt=\"$png 5.10\">"."</div>\n";
        print O12 $_."<img class=\"i514\" src=\"$png-".($do512?"12":"10").".png\" alt=\"$png 5.12\">"."</div>\n" if $do512 or $do510;
        print O14 $_."<img class=\"i514\" src=\"$png-14.png\" alt=\"$png 5.14\">"."</div>\n";
        print O18 $_."<img class=\"i518\" src=\"$png-18.png\" alt=\"$png 5.18\">"."</div>\n";

        $_ .= "<span class=\"i58\" id=\"$png-8\"><a name=\"$png-8\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to hide\">Until 5.8:<img class=\"i58\" src=\"$png-8.png\" alt=\"$png 5.8\"><br>".
          "Since 5.10:<img class=\"i510\" src=\"$png-10.png\" alt=\"$png 5.10\"></a></span><br>".
          "<span class=\"i514\" id=\"$png-14\"><a name=\"$png-14\" href=\"#$png-8\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to show other\">Since 5.14:<img class=\"i514\" src=\"$png-14.png\" alt=\"$png 5.14\"></a></span>".
          "<span class=\"i518\" id=\"$png-18\"><a name=\"$png-18\" href=\"#$png-8\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to show other\">Since 5.18:<img class=\"i518\" src=\"$png-18.png\" alt=\"$png 5.18\"></a></span>";

      } else {
        print O8 $_."<img class=\"i58\" src=\"$png-8.png\" alt=\"$png 5.8\">"."</div>\n"     if $do58;
        print O10 $_."<img class=\"i510\" src=\"$png-10.png\" alt=\"$png 5.10\">"."</div>\n" if $do510;
        print O12 $_."<img class=\"i514\" src=\"$png-".($do512?"12":"10").".png\" alt=\"$png 5.12\">"."</div>\n" if $do512 or $do510;
        print O14 $_."<img class=\"i514\" src=\"$png-14.png\" alt=\"$png 5.14\">"."</div>\n" if $do514;
        print O18 $_."<img class=\"i518\" src=\"$png-18.png\" alt=\"$png 5.18\">"."</div>\n" if $do518;

        print O8 $_."<img class=\"i58\" src=\"$png.png\" alt=\"$png\">"."</div>\n"   if !$do58 and $png{$png.".png"};
        print O10 $_."<img class=\"i510\" src=\"$png.png\" alt=\"$png\">"."</div>\n" if !$do510 and $png{$png.".png"};
        print O12 $_."<img class=\"i510\" src=\"$png.png\" alt=\"$png\">"."</div>\n" if !$do512 and $png{$png.".png"};
        print O14 $_."<img class=\"i514\" src=\"$png.png\" alt=\"$png\">"."</div>\n" if !$do514 and $png{$png.".png"};
        print O18 $_."<img class=\"i518\" src=\"$png.png\" alt=\"$png\">"."</div>\n" if !$do518 and $png{$png.".png"};
        # cases: 58+. (new)/58+none (svpvrv)/58+510+514 (handled above)

        # old hidden
        $_ .= "<span class=\"i58\" id=\"$png-8\"><a name=\"$png-8\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to hide\">Until 5.8:<img class=\"i58\" src=\"$png-8.png\" alt=\"$png 5.8\"></a></span><br>" if $do58;
        $_ .= "<span class=\"i510\" id=\"$png-10\"><a name=\"$png-10\" onclick=\"javascript:Toggle(\'$png-10\')\" title=\"Click to hide\">Since 5.10:<img class=\"i510\" src=\"$png-10.png\" alt=\"$png 5.10\"></a></span><br>" if ($do510 and $do514);
        $_ .= "<span class=\"i514\" id=\"$png-12\"><a name=\"$png-12\" onclick=\"javascript:Toggle(\'$png-12\')\" title=\"Click to hide\">Since 5.12:<img class=\"i514\" src=\"$png-12.png\" alt=\"$png 5.12\"></a></span><br>" if $do512; # ook only
        # new visible, there's always a -8 version
        $_ .= "<span class=\"i514\" id=\"$png-14\"><a name=\"$png-14\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to show other\">Since 5.14:<img class=\"i514\" src=\"$png-14.png\" alt=\"$png 5.14\"></a></span>" if $do514;
        $_ .= "<span class=\"i518\" id=\"$png-18\"><a name=\"$png-18\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to show other\">Since 5.18:<img class=\"i518\" src=\"$png-18.png\" alt=\"$png 5.18\"></a></span>" if $do518;
        $_ .= "<span id=\"$png\"><a name=\"$png\" href=\"#$png-8\" onclick=\"javascript:Toggle(\'$png-8\')\" title=\"Click to show other\">Since 5.10:<img class=\"i514\" src=\"$png.png\" alt=\"$png\"></a></span>" if $do58 and !$do510 and !$do514 and !$do518 and $png{$png.".png"};
      }
      $_ .= "</div>\n";
    }
  } else {
    print O8;
    print O10;
    print O12;
    print O14;
    print O18;
  }
  print O;
}
close I;
chmod 0444, @HTML;
