#!/usr/bin/perl
# This makes a "sounds.json" file covering the music in this datapack.

use warnings;
use strict;

my ($help_screen);
$help_screen = << 'Endofblock';

Usage:  make_sound_json.pl <resource pack folder> <output file>

This searches the specified resource pack folder for ".ogg" files and
creates a sounds.json file with the specified output filename/path.

Endofblock


#
# Main Program


my ($rfolder, $outfile);

$rfolder = $ARGV[0];
$outfile = $ARGV[1];

if (!( (defined $rfolder) && (defined $outfile) ))
{
  print $help_screen;
}
else
{
  my (@flist, $fidx, $thisfile, $thislabel, $thispack);
  my ($outtext, $needcomma);

  @flist = `find $rfolder|grep ogg`;

  # No line break; we add that and an optional comma at the start of each case.
  $outtext = '{';
  $needcomma = 0;

  for ($fidx = 0; defined ($thisfile = $flist[$fidx]); $fidx++)
  {
    if ($thisfile =~ m/\/assets\/(.*)\/sounds\/(.*)\.ogg/)
    {
      $thispack = $1;
      $thisfile = $2;
      $thislabel = $thisfile;
      $thislabel =~ s/\W/\./;

      if ($needcomma)
      { $outtext .= ','; }
      $outtext .= "\n";
      $needcomma = 1;

      $outtext .= '  "music.kmacleod.' . $thislabel . '": {' . "\n";
      $outtext .= << 'Endofblock';
    "category": "record",
    "sounds": [
      {
Endofblock
      $outtext .=
        '        "name": "' . $thispack . ':' . $thisfile . '",' . "\n";
      $outtext .= << 'Endofblock';
        "stream": true
      }
    ]
Endofblock

      # No line break, per above.
      $outtext .= '  }';
    }
  }

  $outtext .= "\n" . '}'."\n";

  if (!open(OFILE, ">$outfile"))
  {
    print "###  Unable to write to \"$outfile\".\n";
  }
  else
  {
    print OFILE $outtext;
    close(OFILE);
  }
}


#
# This is the end of the file.
